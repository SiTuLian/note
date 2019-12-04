### betterScroll的安装
  npm install better-scroll --save

### 基本使用

#### 初始化
  **导入模块**
  import BScroll from 'better-scroll'

```html
<div class="wrapper" >
  <ul>
    <li></li>
    <li></li>
    <li></li>
  </ul>

  //这里可以用其他元素，但不会参与滚动
</div>
```

```js
//在vue项目里元素通过$refs拿到，这样才是唯一的   元素绑定 ref='wrapper'  通过this.$refs.wrapper拿到
const bscroll = new BScroll('.wrapper');
```

#### 注意事项
  - wrapper  只能包裹一个元素不能是很多子标签，用ul包裹很多li是不行的
  - new BScroll('.wrapper');  不能写在created周期函数里，这时组件没挂载，找不到元素，要在mounted里使用
  - 不能用滚轮，要用鼠标拖动才有效，特别是PC端

#### BScroll的配置属性
  ##### 配置属性的设置
```js
   const bscroll = new BScroll(dom,{
     //配置属性
   })
```

  ##### scroll事件
```js
  bscroll.on('scroll', (position)=>{
      console.log(position);
    })
```
  ##### probeType
    - 作用：侦测，是否实时侦测
    - 参数
      + 0，1  不侦测
      + 2     侦测，在手指滚动的过程中侦测，而手指离开的惯性滚动不侦测
      + 3     只要是滚动都侦测

  ##### click
    如果在BScroll滚动区域的div按钮无法监听事件，要讲click设置为true

  ##### pullUpLoad
    值为true时，上拉加载更多，要监听pullingUp事件

  ```js
     bscroll.on('pullingUp', ()=>{
      console.log('上拉加载更多');
      
    })
  ```





