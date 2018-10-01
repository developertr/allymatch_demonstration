<template>
    <div>
        <form autocomplete="off" @submit.prevent="newCategorySubmit" v-show="newCategoryFormView">
            <input type="text" name="category_title" id="" class="form-control" placeholder="Please enter the name" aria-describedby="helpId" v-model="newCategoryTitle">
            <input type="hidden" name="category_id" v-model="categoryId">
            <input type="hidden" name="category_type" v-model="categoryType">
            <div class="text-right">
                <button type="button" class="btn btn-danger" @click="newCategoryFormView=false">Cancel</button>
                <button type="submit" class="btn btn-success">Add</button>
            </div>
        </form>
        <button class="btn addCategoryButton" @click="newCategoryFormView=true" v-show="!newCategoryFormView">+ Add {{ buttonLabel }}</button>
    </div>
</template>

<script>
    export default {
        name: "NewCategory",
        props: {
            categoryId : {
                default : 0,
                type : Number
            },
            categoryType : {
                default : 'product',
                type : String
            },
            categoryKey : {
                default : null,
                type : Number
            },
            subcategoryKey : {
                default : null,
                type : Number
            }
        },
        data() {
            return {
                newCategoryFormView : false,
                newCategoryTitle : '',
                buttonLabel : 'Product'
            }
        },
        mounted: function(){
            if(this.categoryType=='subcategory') {
                this.buttonLabel = 'Sub-Category'
            } else if (this.categoryType=='subproduct') {
                this.buttonLabel = 'Sub-Product'
            }
        },
        methods: {
            newCategorySubmit() {
                var _this = this;
                axios.post('new-category-save',
                    {
                        title : _this.newCategoryTitle,
                        category_id : _this.categoryId,
                        category_type : _this.categoryType
                    }
                ).then(response=>{
                    if(response.status==200) {
                        if(response.data.success) {
                            this.$snotify.success('Category Added');
                            _this.newCategoryTitle = '';
                            _this.newCategoryFormView = false;
                            if (_this.categoryType=='subcategory') {
                                this.$parent.categories[_this.categoryKey].sub_categories.push(response.data.category);
                            } else if (this.categoryType=='subproduct') {
                                this.$parent.categories[_this.categoryKey].sub_categories[_this.subcategoryKey].sub_products.push(response.data.category);
                            } else {
                                this.$parent.categories.push(response.data.category);
                            }
                        } else {
                            this.$parent.$parent.showErrors(response.data.errors);
                        }
                    }
                }).catch(error=>{
                    alert(error);
                })
            }
        }
    }
</script>

<style scoped>

</style>
