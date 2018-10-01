<template>
    <div class="categories">
        <div v-show="!completed">
            <div class="mainTitle">
                Products
                <button @click="clickDone()">Done</button>
            </div>
            <ul>
                <li v-for="(category, key) in categories">
                    <div class="name" v-bind:class="{ selected: category.selected }" @click="category.selected=!category.selected">
                        {{ category.title }}
                    </div>
                    <div class="selectTitle" v-show="category.selected==1">
                        <a data-toggle="collapse" class="collapsed" v-bind:href="'#category'+category.id">
                            Select Subcategories
                        </a>
                    </div>
                    <div class="collapse" v-bind:id="'category'+category.id">
                        <ul v-show="category.selected==1">
                            <li v-if="category.sub_categories.length>0">
                                <div class="search">
                                    <input type="text" @keyup="searchSubCategory(key,$event.target.value)" placeholder="search" class="form-control">
                                </div>
                            </li>
                            <li v-for="(subcategory,subkey) in category.sub_categories" v-if="subcategory.visible==1">
                                <div class="name" v-bind:class="{ selected: subcategory.selected }" @click="subcategory.selected=!subcategory.selected">
                                    {{ subcategory.title }}
                                </div>
                                <div class="selectTitle subproduct" v-show="subcategory.selected==1">
                                    <a data-toggle="collapse" class="collapsed" v-bind:href="'#subcategory'+subcategory.id">
                                        Select Sub-products
                                    </a>
                                </div>
                                <div class="collapse" v-bind:id="'subcategory'+subcategory.id">
                                    <ul v-show="subcategory.selected==1">
                                        <li v-if="subcategory.sub_products.length>0">
                                            <div class="search">
                                                <input type="text" @keyup="searchSubProduct(key,subkey,$event.target.value)" placeholder="search" class="form-control">
                                            </div>
                                        </li>
                                        <li v-for="product in subcategory.sub_products" v-if="product.visible==1">
                                            <div class="name" v-bind:class="{ selected: product.selected }" @click="product.selected=!product.selected">
                                                {{ product.title }}
                                            </div>
                                        </li>
                                        <li>
                                            <new-category class="subProductAddButton" :category-id="subcategory.id" :category-type="'subproduct'" :category-key="key" :subcategory-key="subkey" v-if="subcategory.selected==1"></new-category>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <new-category class="subCategoryAddButton" :category-id="category.id" :category-type="'subcategory'" :category-key="key" v-if="category.selected==1"></new-category>
                            </li>
                        </ul>
                    </div>
                </li>
                <li>
                    <new-category></new-category>
                </li>
            </ul>
        </div>
        <div class="completed" v-show="completed">
            <div>
                <b>Products</b>
                <label v-for="select_category in active_categories">
                    {{ select_category.title }}
                </label>
            </div>
            <div v-if="active_subcategories.length>0">
                <b>Sub categories</b>
                <label v-for="select_subcategory in active_subcategories">
                    {{ select_subcategory.title }}
                </label>
            </div>
            <div v-if="active_subproducts.length>0">
                <b>Sub products</b>
                <label v-for="select_subproduct in active_subproducts">
                    {{ select_subproduct.title }}
                </label>
            </div>
            <button @click="completed = !completed">
                Save
            </button>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Categories",
        data() {
            return {
                categories : [],
                active_categories : [],
                active_subcategories : [],
                active_subproducts : [],
                active_sub_category_list : [],
                active_sub_products_list : [],
                completed : false
            }
        },
        mounted() {
            this.getCategories();
            if (this.categoryId>0) {
                this.buttonLabel = 'Category';
            }
        },
        methods: {
            searchSubCategory(getKey,search) {
                this.categories[getKey].sub_categories.forEach(function(subcategory){
                   if(subcategory.title.toLowerCase().indexOf(search.toLowerCase()) == -1) {
                       subcategory.visible = 0;
                   } else {
                       subcategory.visible = 1;
                   }
                });
            },
            searchSubProduct(getKey,getSubKey,search) {
                this.categories[getKey].sub_categories[getSubKey].sub_products.forEach(function(product){
                    if(product.title.toLowerCase().indexOf(search.toLowerCase()) == -1) {
                        product.visible = 0;
                    } else {
                        product.visible = 1;
                    }
                });
            },
            getCategories() {
                var _this = this;
                axios.get('get-categories/'+this.categoryId)
                .then(response => {
                    _this.categories=response.data;
                })
                .catch(error=>{

                });
            },
            clickDone() {
                var _this = this;
                _this.active_categories = [];
                _this.active_subcategories = [];
                _this.active_subproducts = [];

                this.active_categories = this.categories.filter(function (category) {
                    return category.selected == 1;
                });

                if (this.active_categories.length==0) {
                    this.$snotify.error('Please Add Filter');
                } else {
                    this.completed = true;
                }

                this.active_categories.forEach(function(category) {
                    _this.active_sub_category_list = category.sub_categories.filter(function (subcategory) {
                        return subcategory.selected == 1;
                    });
                    _this.active_sub_category_list.forEach(function(subcategory){
                       _this.active_subcategories.push(subcategory);
                    });
                });

                this.active_subcategories.forEach(function(subcategory) {
                    _this.active_sub_products_list = subcategory.sub_products.filter(function (product) {
                        return product.selected == 1;
                    });
                    _this.active_sub_products_list.forEach(function(product){
                        _this.active_subproducts.push(product);
                    });
                });
            }
        }
    }
</script>

<style scoped>

</style>
