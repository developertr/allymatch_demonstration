require('babel-polyfill');
require('./bootstrap');
import axios from 'axios';
import Vue from 'vue';

import Snotify from 'vue-snotify';
import 'vue-snotify/styles/material.css'; // or dark.css or simple.css
Vue.use(Snotify);

Vue.component('categories', require('./components/Categories.vue'));
Vue.component('new-category',require('./components/NewCategory.vue'));

const app = new Vue({
    el: '#allymatchapp',
    methods:{
        showErrors : function(errors) {
            var errorSize = this.objectSize(errors);
            var i = 0;
            for (i = 0; i < errorSize; i++) {
                var message = Object.values(errors)[i];
                this.$snotify.error(message[0]);
            }
        },
        objectSize : function(obj) {
            var size = 0, key;
            for (key in obj) {
                if (obj.hasOwnProperty(key)) size++;
            }
            return size;
        },
        formatNumber(value) {
            let val = (value/1).toFixed(0).replace('.', ',');
            return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
        }
    }
});
