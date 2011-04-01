(function() {
    
    if (!jasmine) {
        throw new Exception("jasmine library does not exist in global namespace!");
    }
    
    /**
	* Jasmine reporter that outputs spec results to a new window inside your iOS 
	* application. Useful if you are developing iOS applications with Titanium 
	* Mobile and wants to unit test your code.
	*
	* Usage:
	*
	* jasmine.getEnv().addReporter(new jasmine.TitaniumReporter());
	* jasmine.getEnv().execute();
	*/
	var TitaniumReporter = function() {
		// create Titanium Window and WebView to display results
		var titaniumTestWindow = Titanium.UI.createWindow({
			title:'Application Tests',
			backgroundColor: 'white',
			zIndex: 999
		});
		
		var titaniumTestsResultsWebView = Ti.UI.createWebView({
			html: '',
			top: 5,
		    left: 5,
			width: 310,
			height: 470
		});
		titaniumTestWindow.add(titaniumTestsResultsWebView);
		titaniumTestWindow.open();
		
		var testResults = '';
		var testResultsHeader = '<html><head><style type="text/css">body{font-size:10px;font-family:helvetica;}</style></head><body>';
		var testResultsFooter = '</body></html>';
		
		this.updateTestResults = function(message) {
			testResults += message;
			titaniumTestsResultsWebView.html = testResultsHeader + testResults + testResultsFooter;
		};
    };

    TitaniumReporter.prototype = {
        reportRunnerResults: function(runner) {
            //this.log('<h3>Test Runner Finished.</h3>');
        },

        reportRunnerStarting: function(runner) {
            this.log('<h3>Test Runner Started.</h3>');
        },

        reportSpecResults: function(spec) {
			var color = '#FF0000';
            if (spec.results().passed()) {
                color = '#009900';
            }

            //this.log('[' + spec.suite.description + '] <font color="' + color + '">' + spec.description + '</font><br>');
			this.log('• <font color="' + color + '">' + spec.description + '</font><br>');
        },

        reportSpecStarting: function(spec) {
            //this.log('[' + spec.suite.description + '] ' + spec.description + '... ');
        },

        reportSuiteResults: function(suite) {
            var results = suite.results();

            this.log('<b>[' + suite.description + '] ' + results.passedCount + ' of ' + results.totalCount + ' passed.</b><br><br>');
        },

        log: function(str) {
            this.updateTestResults(str);
        }
    };
    
    // export public
    jasmine.TitaniumReporter = TitaniumReporter;
})();