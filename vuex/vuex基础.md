### vuex的基本使用

#### 安装
  npm install vuex --save

#### 使用
  ```js
    import Vue from 'vue'
    import Vuex from 'vuex'
    
    //安装插件
    Vue.use(Vuex)

    //实例化
    const store = new Vuex.Store({
      state:{ /*变量*/ },
      mutations: { /*方法*/ },
      actions: { /*异步操作*/ },
      getters: { /*相当于计算属性，获取state进行加工 */},
      modules: { /*在这里可以继续创建state*/ }
    })

    //导出
    export default store
  ```

  ```js
    //main.js引入
    import store from './store.js'

    new Vue({
      store
    })

    //使用只需要用 如 this.$store.state 的语法
  ```

### state的使用
  ```js
    //.vue单文件的html模板直接用 {{$store.state}}

    //在js用 this.$store.state
  ```

### mutations的使用
  ```js
   const store = new Vuex.Stroe({
      state:{
        counter: 0
      },
      //非异步操作用mutations修改state
      mutations: {
        increment(state){
          state.counter++
        },
        //mutations 传参
        incrementMore(state, count){
          state.counter += count
        },
        //另一种提交风格
        incrementMore1(state, playLoad){
          state.counter += playLoad.count
        },
        //定义类型常量
        //创建js文件 export const INCREMENT = 'increment'
        //导入
        [INCREMENT](){
          //
        }

      },
      actions: { /*异步操作*/ },
      getters: { /*相当于计算属性，获取state进行加工 */},
      modules: { /**/ }
    })

     //vuex的响应式数据，只有在初始化添加进state的才会有响应式
    //通过Vue.set(state.对象o,"属性","值") 添加 会加入到响应式系统
    //通过Vue.delete(stote.对象,"属性") 删除 可以出发响应式系统
  ```

  **在要使用的地方**
  ```html
    <button @click="add">按钮</button>
    <button @click="addMore">按钮+5</button>
    <button @click="addMore1">按钮+5</button>
  ```

  ```js
    export default {
      name: 'name',
      methods: {
        add(){
          //通过commit进行提交
          this.$store.commit('increment')
        },
        // mutations 传参
        addMore(count){
          this.$store.commit('incrementMore', count)
        },
        //另一种提交风格
        addMore1(count){
          this.$store.commit({
            type: 'incrementMore1',
            count
          })
        },
      }
    }

   
  ```

### getters的使用
  ```js
   const store = new Vuex.Stroe({
      state:{
        count: 0
      },
      //非异步操作用mutations修改state
      mutations: {
        
      },
      actions: { /*异步操作*/ },
      getters: {
        powerCount(state){
          return state.count * state.count
        }
      },
      modules: { /**/ }
    })

//------------------------------------------------
    //getters的参数
    const store = new Vuex.Stroe({
      state:{
        count: 0
      },
      //非异步操作用mutations修改state
      mutations: {
        
      },
      actions: { /*异步操作*/ },
      getters: {
        powerCount(state){
          return state.count * state.count
        },
        //规定第一个参数就是state，第二个是getters，参数名发生改变没有影响
        powerCountLength(state, getters){
          return getters.powerCount + 2
        },
        //动态传参
        func(state){
          return function(age){
            return state.students.filter(s => s.age>age)
          }
        },
      },
      modules: { /**/ }
    })


  ```

  在要使用的地方
  ```html
    <div>{{$store.getters.powerCount}}</div>
    <!-- 动态传参 -->
    <div>{{$store.getters.func(8)}}</div>
  ```

  ### actions的使用

  ```js
    const store = new Vuex.Stroe({
      state:{ /*变量*/ },
      mutations: {
        addMore(){
          // 
        }
      },
      //操作state的数据的 异步方法在这里进行
      actions: {
        // content => state
        aUpdate(content){
          setTimeout( () => {
            content.commit('addMore')
          }, 1000)
        },
        //参数
        aUpdate1(content, payload){
          setTimeout( () => {
            content.commit('addMore')
          }, 1000)
        },
        //如果要通知操作完成
        aUpdate2(content, payload){
          return new Promise( (resolve, reject) => {
            setTimeout( () => {
              content.commit('addMore')
              console.log(payload)

              resolve('操作完成')
            }, 1000)
          } )
        },
        
      },
      getters: { /*相当于计算属性，获取state进行加工 */},
      modules: { /**/ }
    })
  ```


  在要使用的地方
  ```html
    <button @click="add">按钮</button>
  ```

  ```js
    export default {
      name: 'name',
      methods: {
        add(){
          this.$store.dispatch('aUpdate')
        },
        // 通知操作完成，利用Promise
        add1(){
          this.$store.dispatch('aUpdate2', '信息')
          .then( res => {
            console.log(res)
          } )
        }
        
      }
    }
  ```

### modules的使用
  ```js
    const moduleA = {
       state:{ 
         name: '张三'
        },
          mutations: { /*方法*/ },
          actions: { /*异步操作*/ },
          getters: {
            // 模块可以有第三参数,第三个是根的state
            func1(state,getters, rootstate){
              // 
            }
          },
          modules: {
         //这里还可以继续写，但是没必要
      }
    }

    const store = new Vuex.Stroe({
      state:{ /*变量*/ },
      mutations: { /*方法*/ },
      actions: { /*异步操作*/ },
      getters: { /*相当于计算属性，获取state进行加工 */},
      modules: {
          a: moduleA,
          b: {
            state:{ /*变量*/ },
            mutations: { /*方法*/ },
            actions: { /*异步操作*/ },
            getters: { /*相当于计算属性，获取state进行加工 */},
            modules: {}
          }
       }
    })
  ```

  ```html
    <!-- 使用 -->
    <!-- 会把 modules的 属性 加到 state里 -->
    <div>{{$store.state.a.name}}</div>
    <!-- getters 使用就  $store.getters.func -->
  ```

​    
