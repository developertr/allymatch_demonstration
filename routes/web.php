<?php
route::get('/','DemonstrationController@index');
route::post('new-category-save','DemonstrationController@addCategory');
route::get('get-categories','DemonstrationController@getCategories');
