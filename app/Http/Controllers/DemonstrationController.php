<?php

namespace App\Http\Controllers;

use App\Categories;
use Validator;
use Response;
use Illuminate\Http\Request;

class DemonstrationController extends Controller
{
    public function index() {
        return view('home');
    }

    public function addCategory(Request $request) {
        $validator=Validator::make($request->all(),[
            'title'=>'required',
            'category_id'=>'required|numeric'
        ]);
        if ($validator->fails()) {
            return Response::json(array('success' => false,'errors'=>$validator->errors()));
        } else {
            $newCategory = new Categories();
            $newCategory->category_id = $request->category_id;
            $newCategory->title = $request->title;
            $newCategory->save();

            $newCategory->setAttribute('selected',0);
            $newCategory->setAttribute('visible',1);
            if ($request->category_type=='product') {
                $newCategory->setAttribute('sub_categories',[]);
            } elseif ($request->category_type=='subcategory') {
                $newCategory->setAttribute('sub_products',[]);
            }

            return Response::json(array('success'=>true,'category'=>$newCategory));
        }
    }

    public function getCategories() {
        $categories = Categories::where('category_id',0)->get();
        foreach($categories as $category) {
            $category->setAttribute('selected',0);
            $category->setAttribute('sub_categories',Categories::where('category_id',$category->id)->get());
            foreach($category->sub_categories as $sub_category) {
                $sub_category->setAttribute('selected',0);
                $sub_category->setAttribute('visible',1);
                $sub_category->setAttribute('sub_products',Categories::where('category_id',$sub_category->id)->get());
                foreach($sub_category->sub_products as $product) {
                    if (isset($product)) {
                        $product->setAttribute('selected',0);
                        $product->setAttribute('visible',1);
                    }
                }
            }
        }
        return Response::json($categories);
    }
}
