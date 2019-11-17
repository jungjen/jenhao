#!/bin/bash

mkdir -p lib data coffee coffee/server coffee/jsx coffee/test webroot webroot/js webroot/js/jquery webroot/js/react webroot/css

cp node_modules/jquery/dist/jquery.min.js webroot/js/jquery/jquery.min.js
cp node_modules/jquery/dist/jquery.js webroot/js/jquery/jquery.js

cp node_modules/js-cookie/src/js.cookie.js webroot/js/js.cookie.js

cp node_modules/react/umd/react.production.min.js webroot/js/react/react.min.js
cp node_modules/react/umd/react.development.js webroot/js/react/react.js

cp node_modules/react-dom/umd/react-dom.production.min.js webroot/js/react/react-dom.min.j
cp node_modules/react-dom/umd/react-dom.development.js webroot/js/react/react-dom.js

cp node_modules/redux/dist/redux.min.js webroot/js/react/redux.min.js
cp node_modules/redux/dist/redux.js webroot/js/react/redux.js

cp node_modules/react-redux/dist/react-redux.min.js webroot/js/react/react-redux.min.js
cp node_modules/react-redux/dist/react-redux.js webroot/js/react/react-redux.js

cp node_modules/react-router-dom/umd/react-router-dom.min.js webroot/js/react/react-router-dom.min.js
cp node_modules/react-router-dom/umd/react-router-dom.js webroot/js/react/react-router-dom.js

cp node_modules/react-semantic-ui/react-semantic-ui.min.js webroot/js/react/react-semantic-ui.min.js
cp node_modules/react-semantic-ui/react-semantic-ui.js webroot/js/react/react-semantic-ui.js

cp node_modules/react-semantic-ui-range/range.js webroot/js/react/react-semantic-range.js
cp node_modules/react-semantic-ui-range/range.css webroot/css/react-semantic-range.css

cp node_modules/echarts/dist/echarts.min.js webroot/js/echarts.min.js
cp node_modules/echarts/dist/echarts.js webroot/js/echarts.js
