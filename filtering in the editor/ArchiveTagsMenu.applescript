property pTitle : "Archive chosen tag-types to matching section"

					  (FoldingText is Copyright (c) 2014 Jesse Grosjean)
"

	Archives all line tagged with a tag chosen from a menu,
	to a section '# Archive  <Tagname>'.

	To change the affected tag, edit the tagname in property precOptions below this line.

	(if you comment out the precOptions line, the script will offer a menu,
	 listing each type of tag found in the document )
"

-- INCLUDE A LINE LIKE THE FOLLOWING TO BY-PASS THE MENU AND CREATE A SCRIPT SPECIFIC TO ONE TAG TYPE
	function(editor) {
		// Skip any line already archived with an ancestor
		function rootsOnly(oTree, lstNodes) {
			var lstSeen = [], strID, oParent, lngNodes=lstNodes.length, oNode,i;
			
			nextnode: for (i=0; i<lngNodes;i++) {
				oNode = lstNodes[i];
				strID = oNode.id;
				oParent = oNode.parent
				while (oParent) {
					if (lstSeen.indexOf(oParent.id) !== -1) continue nextnode
					oParent=oParent.parent;
				}
				lstSeen.push(strID);
			}
			lngNodes = lstSeen.length;
			for (i=lngNodes; i--;) {
				lstSeen[i] = oTree.nodeForID(lstSeen[i]);
			}
			return lstSeen;
		}

		var tree = editor.tree(), nodeArchive, oNode, rngArchive=null,
			lstTags = options.tagset, lstTagged, lstRoots,
			strID, strTag, strPath, strArchive,
			lngTags = lstTags.length, lngRoots, i,j;

		tree.beginUpdates();
		tree.ensureClassified();

		for (i=lngTags; i--;) {
			strTag = lstTags[i];
			if (strTag) {
				strArchive = 'Archive ' + strTag.charAt(0).toUpperCase() + strTag.slice(1);
				strPath = '//(@line:text=' + strArchive + ')[0]';
				nodeArchive = tree.evaluateNodePath(strPath)[0];
				if (!nodeArchive) {
					nodeArchive = tree.createNode('# ' + strArchive);
					tree.appendNode(nodeArchive);
				}
				
				strPath = '//@' + strTag + ' except //@line:text =\"' +
					strArchive + '\"//@' + strTag;
				lstTagged = tree.evaluateNodePath(strPath);

				lstRoots = rootsOnly(tree, lstTagged);
				lngRoots = lstRoots.length;
				for (j=lngRoots; j--;) {
					nodeArchive.insertChildBefore(
						lstRoots[j], nodeArchive.firstChild);
				}
			}
		}
		tree.endUpdates();
		if (nodeArchive) {
			rngArchive = tree.createRangeFromNodes(nodeArchive,0,nodeArchive,-1);
			editor.scrollRangeToVisible(rngArchive);
			editor.setSelectedRange(rngArchive);
		}
	}

"