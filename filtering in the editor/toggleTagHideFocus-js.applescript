function run() {
	/*jshint multistr:true */
	var dctOpt = {
		title: "View/hide tags in FT document",
		ver: "0.2",
		description: "Hides or focuses on particular tags.\
					  and shows active node paths with counts of hidden\
					  and visible tags of each kind.",
		author: "RobTrew",
		license: "MIT",
		site: "https://github.com/RobTrew/txtquery-tools"
	};

	function visibleTags(ed) {
		var oTree = ed.tree(),
			lstTags = oTree.tags().sort(),
			lstNodes, lstVisible = [],
			strTag, j, lngNodes,
			lngHidden = 0,
			lngShown = 0;

		for (var lng = lstTags.length, i = 0; i < lng; i++) {
			strTag = lstTags[i];
			lstNodes = oTree.evaluateNodePath('//@' + strTag);
			lngNodes = lstNodes.length;

			lngHidden = 0;
			for (j = lngNodes; j--;) {
				if (ed.nodeIsHiddenInFold(lstNodes[j])) lngHidden += 1;
			}
			lstVisible.push(
				lngHidden ?
				('@' + strTag + '\t' + (lngNodes - lngHidden) + '/' + lngNodes) + ' → focus' :
				('@' + strTag + '\t' + lngNodes) + ' → hide'
			);

		}
		return lstVisible;
	}

	function updateView(ed, opt) {

		function updatedPath(strOldPath, lstChoice) {
			var lstParts, lstScore, lstShow = [],
				lstHide = [],
				strPath = '',
				strShow, strHide,
				lngVisible, lngTotal,
				lng = lstChoice.length,
				i;

			// Partial || None -- > Focus
			// All -- > Hide
			for (i = lng; i--;) {
				lstParts = lstChoice[i].split('\t');

				if ('SHOW ALL' === lstParts[0]) {
					return '///*';
				}

				lstScore = lstParts[1].split('/');
				lngVisible = lstScore[0];
				lngTotal = lstScore[1];

				if (lngVisible < lngTotal) lstShow.push(lstParts[0]);
				else lstHide.push(lstParts[0]);
			}

			lng = lstShow.length;
			if (lng) {
				strPath = '//' +
					((lng > 1) ? '(' + lstShow.join(' or ') + ')' :
					lstShow[0]);
			}

			lng = lstHide.length;
			if (lng) {
				strHide =
					(lng > 1) ? '(' + lstHide.join(' or ') + ')' :
					lstHide[0];

				strPath = strPath ?
					(strPath + ' except //' + strHide) :
					('//not ' + strHide);

				if (strPath) strPath += ' except //' + strHide;
				else strPath = '//not ' + strHide;
			}
			return strPath;
		}

		var strNewPath = updatedPath(opt.oldPath, opt.choice);
		ed.setNodePath(strNewPath);
		return strNewPath;
	}

	function docPath(ed) {
		return ed.nodePath().toString();
	}

	var docsFT = Application("FoldingText").documents(),
		app = Application.currentApplication(),
		lngDocs = docsFT.length,
		oDoc = lngDocs ? docsFT[0] : null,
		strPath, strNewPath = '///*',
		lstHide = [],
		lstFocus = [],
		lstTagSet,
		varChoice = true;

	if (lngDocs) {
		lstTagSet = oDoc.evaluate({
			script: visibleTags.toString()
		});
		lstTagSet.push('SHOW ALL\t');
		strPath = oDoc.evaluate({
			script: docPath.toString()
		});

		app.includeStandardAdditions = true;
		if (lstTagSet.length) {
			while (varChoice) {
				app.activate();
				varChoice = app.chooseFromList(lstTagSet, {
					withTitle: dctOpt.title + ' ' + dctOpt.ver,
					withPrompt: 'active node path:\n\n' + strPath +
						'\n\n' + '( visible / total ) → action\n\n' +
						'⌘-click for multiple tag(s):',
					defaultItems: [lstTagSet[lstTagSet.length - 1]],
					multipleSelectionsAllowed: true
				});

				if (varChoice) {
					// Get a new path
					strNewPath = oDoc.evaluate({
						script: updateView.toString(),
						withOptions: {
							oldPath: strPath,
							choice: varChoice
						}
					});
					// and update the list of tag visibilities
					strPath = strNewPath;
					lstTagSet = oDoc.evaluate({
						script: visibleTags.toString()
					});
					lstTagSet.push('SHOW ALL\t');
				}
			}
		}
	}

	return strNewPath;
}