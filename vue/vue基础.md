### v-if和v-show的区别
  - v-if是把整个元素删除
  - v-show是添加display: none;的样式

### v-model
  - 适用于<input>，<textarea>，<select>
  #### 文本
  <input v-model="message" placeholder="edit me">
  <p>Message is: {{ message }}</p>
  #### 多行文本
  <span>Multiline message is:</span>
  <p style="white-space: pre-line;">{{ message }}</p>
  <br>
  <textarea v-model="message" placeholder="add multiple lines"></textarea>
  在文本区域插值 (<textarea>{{text}}</textarea>) 并不会生效，应用 v-model 来代替。
  #### 复选框
  - 单个复选框绑定到布尔值中
    <input type="checkbox" id="checkbox" v-model="checked">
    <label for="checkbox">{{ checked }}</label>
  - 多个复选框绑定数组中
  <div id='example-3'>
    <input type="checkbox" id="jack" value="Jack" v-model="checkedNames">
    <label for="jack">Jack</label>
    <input type="checkbox" id="john" value="John" v-model="checkedNames">
    <label for="john">John</label>
    <input type="checkbox" id="mike" value="Mike" v-model="checkedNames">
    <label for="mike">Mike</label>
    <br>
    <span>Checked names: {{ checkedNames }}</span>
  </div>
```js
  new Vue({
    el: '#example-3',
    data: {
      checkedNames: []
    }
  })
```
  #### 单选按钮
  <div id="example-4">
    <input type="radio" id="one" value="One" v-model="picked">
    <label for="one">One</label>
    <br>
    <input type="radio" id="two" value="Two" v-model="picked">
    <label for="two">Two</label>
    <br>
    <span>Picked: {{ picked }}</span>
  </div>

  ```js
    new Vue({
      el: '#example-4',
      data: {
        picked: ''
      }
    })
  ```

  #### 选择框
  <div id="example-5">
    <select v-model="selected">
      <option disabled value="">请选择</option>
      <option>A</option>
      <option>B</option>
      <option>C</option>
    </select>
    <span>Selected: {{ selected }}</span>
  </div>

   ```js
    new Vue({
      el: '#example-5',
      data: {
        selected: ''
      }
    })
   ```

  #### 修饰符
  - .lazy 在“change”时而非“input”时更新
  - .number 自动将用户的输入值转为数值类型，默认为字符串
  - .trim 自动过滤用户输入的首尾空白字符

  #### v-for中的key属性
    主要用在 Vue 的虚拟 DOM 算法，在新旧 nodes 对比时辨识 VNodes

### 生命周期
  - beforeCreate  组件未创建之前
  - created 组件创建完成，但位挂载，这时不能获取元素
  - beforeMount 组件挂载之前
  - mounted 元素挂载之后
  - beforeUpdate  data被修改时，虚拟DOM重新渲染并更新之前
  - updated 虚拟DOM重新渲染并更新之后
  - beforeDestroy  组件销毁之前
  - destroyed 组件销毁之后
