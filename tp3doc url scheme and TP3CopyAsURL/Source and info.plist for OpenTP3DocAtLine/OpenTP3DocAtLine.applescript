property pTitle : "Register and handle tp3doc:// url scheme"

	Use in conjunction with the 'TP3CopyAsURL' Applescript to get
	a URL which opens the specified document, optionally restoring selection and filter state.

"

function(editor, options) {
	function getValue(strSwitch) {
		return lstSwitches[lstSwitches.indexOf('?' + strSwitch + '=')+1];
	}
	
	var	tree= editor.tree(),
		oNode, rngSeln,
		//options.filepath, options.switches, options.keys
		lstKeys = options.keys,
		strRegex = '(\\\\?' + lstKeys.join('=|\\\\?') + '=)',
		oRegex = new RegExp(strRegex, 'g'),
		strPath = decodeURIComponent(options.filepath), 
		strSwitches = decodeURIComponent(options.switches),
		lstSwitches = strSwitches.split(oRegex),
		strPath, strLineNum,
		strSelnPath,
		strFind,
		strStartOffset, strEndOffset,
		lngLine, lngStartOffset=0, lngEndOffset=-1,
		varStartOffset, varEndOffset,
		lstMatches=[], lstRanges=[], i;
		
	
	// Try to restore any selection that is specified
	if (strPath = getValue('nodepath')) {
		//restore any filter
		editor.setNodePath(strPath);
	}
		
	
	strSelnPath = getValue('selnpath');
	strFind = getValue('find');
	
	if (strSelnPath || strFind) {
		if (strSelnPath) {
			lstMatches = tree.evaluateNodePath(strSelnPath);
		}
		if (strFind && (lstMatches.length == 0)) {
			lstMatches = tree.evaluateNodePath('//\"' + strFind + '\"');
		}
		if (lstMatches.length) {
			lstMatches.forEach(function(varNode) {
				lstRanges.push(tree.createRangeFromNodes(
					varNode, 0, varNode, varNode.line().length));
				// unfold if this range is hidden
				if (editor.nodeIsHiddenInFold(varNode)) {
					editor.expandToRevealNode(varNode);
				}
			});
			editor.setSelectedRanges(lstRanges);
			//Make sure that at least the first of any selections is visible
			editor.scrollRangeToVisible(lstRanges[0]);
		}
	} else {
		
		// make any selection specified by line number etc
		if (strLine = getValue('line')) {
			lngLine = parseInt(strLine, 10);
			if (!(isNaN(lngLine))) {
				oNode = tree.lineNumberToNode(lngLine);
				if (editor.nodeIsHiddenInFold(oNode)) {
					editor.expandToRevealNode(oNode);
					editor.scrollToLine(lngLine);
				}
		
				if (strStartOffset = getValue('startoffset')) {
					varStartOffset = parseInt(strStartOffset, 10);
					if (!isNaN(varStartOffset)) {
						lngStartOffset = varStartOffset;
					}
				}
		
				if (strEndOffset = getValue('endoffset')) {
					varEndOffset = parseInt(strEndOffset, 10);
					if (!isNaN(varEndOffset)) {
						lngEndOffset = varEndOffset;
					}
				}

				rngSeln = tree.createRangeFromNodes(
					oNode, lngStartOffset, oNode, lngEndOffset);
				editor.setSelectedRange(rngSeln);
			}
		}
	}
}
"