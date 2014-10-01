property pTitle : "Move line(s) to new section"

	1. Select one or more lines in FoldingText
	2. Run this script and choose a target section from the menu
"
	function(editor, options) {

		// FIND THE TARGET SECTION
		var oTree=editor.tree(),
			oNewParent=oTree.evaluateNodePath(options.targetpath + '[0]')[0],
			rngSeln = editor.selectedRange(),
			lstNodes = rngSeln.nodesInRange(), 
			lstSeen=[], lstSelnRoots=[], strID;
		
		// WORK ONLY WITH THE HIGHEST LEVEL NODES IN THE SELECTION
		// (CHILDREN TRAVEL WITH THEM)
		lstNodes.forEach(function (oNode) {
			strID=oNode.parent.id;
			if (lstSeen.indexOf(strID) == -1) {
				lstSelnRoots.push(oNode);
				lstSeen.push(oNode.id);
			}
		});

		// APPEND EACH SELECTED PARENT NODE TO THE CHOSEN TARGET NODE
		// Taking children with each parent, unless we are relocating an ancestor under one
		// of its own descendants (demoted ancestors travel alone)

		lstSelnRoots.forEach(function (oNode) {
			if (oNewParent.isAncestorOfSelf(oNode)) { //detach traveller from its descendants before moving it
				oTree.removeNode(oNode);
			}
			oNewParent.appendChild(oNode); // by default children travel with parents
		});
	}
"

	// GATHER LIST OF SECTIONS FOR THE UI MENU
	function(editor) {
		var  libNodePath = require('ft/core/nodepath').NodePath,
			oTree = editor.tree(),
			lstHeads = oTree.evaluateNodePath('//@type=heading'),
			lstMenu = [], lstPath=[], lstSelnNodes=editor.selectedRange().nodesInRange(),
			lngSeln=lstSelnNodes.length,
			rngLines, strText='';

			if (lngSeln) {
				rngLines = oTree.createRangeFromNodes(lstSelnNodes[0],0,lstSelnNodes[lngSeln-1],-1);
				strText = rngLines.textInRange();
			}
	
			lstHeads.forEach(function(oHead) {
				lstPath.push(libNodePath.calculateMinNodePath(oHead));
				lstMenu.push(
					[
						Array(oHead.typeIndentLevel()+1).join('#'),
						oHead.text()
					].join(' ')
				);
			});
	
			return [lstMenu, lstPath, strText];
	}
"