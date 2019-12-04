### JavaScript的内存模型

  直接量和对象两种类型的属性在内存中的保存方式不同，直接量是直接用两块内存分别保存属性名和属性值，而对象需要三块，分别保存属性名，属性地址和属性内容。

  ```javascript
  function F(){
      this.v = 1;
    }

    let f = new F();
    let f1 = f;
    console.log(f1.v);// 1
    f1.v = 2;
    console.log(f.v);// 2
    f = null;
    console.log(f1.v);// 2
  ```

  属性名只是指向了保存对象的内存地址，而不是指向实际的对象。
  f和f1，实际上指向同一个地址，所以改变f1.v，f.v也会受影响，f=null,也只是把f指向地址的线给断开，与f1并无影响

  ### apply与call

```javascript
//这两个是逆调用的方法，通过方法来调用对象
let obj = {v:123};
  function log(num){
    console.log(this.v*num);
  }
  log.apply(obj,[10]);
  log.call(obj,10);

  // apply在传递多个参数时是用数组的，而call直接一个一个传递
```

  ### 方法中的变量和实例对象的属性是相互独立的

```javascript
function Obj(){
    var v = 4;
    this.v = 5;
    console.log(v) // 4
  }

  new Obj();
```

  ### Set 一个集合，没有重复的元素

  ```javascript
    let arr = [1,2,3,4,5,1,2];
    let set = new Set(arr);

    for(item of set){
      console.log(item); // 1,2,3,4,5
    }

    //Set对象有一个size属性和8个方法，add,claer,delete,has,keys,entries,forEach,values

    //size 集合里元素的个数
    set.size
 
    //add 添加元素, 如果添加的元素已存在集合里，则添加无效
    set.add('h').add('5');

    // delete 删除指定元素
    set.delete('5');
   
    //clear 清空集合
    set.clear();

    //has 检查集合中是否包含指定的元素
    set.has(1) // true

    //keys 和 values 都返回Set的Iterator
    for(let k of arr.keys()){
      console.log(k); //返回下标 0,1,2,3,4
    }

    
    for(let k of arr.values()){
      console.log(k); // 返回值 1,2,3,4,5
    }

    //entries 在Map会返回键值对，但在Set 是 下标 - 值
    for(let k of arr.entries()){
      console.log(k); // 返回值 1,2,3,4,5
    }

    //forEach 可以传递函数
    set.forEach(function(num){
      if(num > 2){
        console.log(num)
      }
    })
  ```

  ### Map 键值对

  ```javascript

    //set 添加  get 获取
    map.set('name','张三');
    map.set('age',11);

    map.get('name')// 张三
    map.get('张三') // undefined 

    //size 集合元素的个数
    map.size
    
    // delete 删除指定元素
    map.delete('age');

    // clear 清空集合

    // keys, hs, values, entries, forEach 与 Set 用法一样

  ```

  ### WeakSet 与 WeakMap
    弱化的Set 和 Map，垃圾回收器，不会关注元素在里面的引用，如果在外部没有引用，那么可能会回收其内存，这样有效的避免内存泄露的问题

  **区别**

  WeakSet 和 WeakMap 的 key只能是对象类型，WeakMap的vaule可以是任意类型
  WeakSet 和 WeakMap 没有 size属性，没有clear方法，不可以遍历所包含的元素

  ### 异步处理

  ```js
    function approve(approver, resolve, reject){
      setTimeout(()=>{
        if(new Date().getMilliseconds()%2 == 1){
          resolve(`${approver}:同意`);
        }else{
          let r = ['内容不准确','材料不全','其他'];
          reject(`${approver}:流程返回，原因:
          ${r[Math.trunc(Math.random()*r.length)]}`)
        }
      }, 1000)
    }

    console.log('准备提交流程')

    new Promise((resolve, reject)=>{
      console.log('开始流程')
      
      approve('处长', resolve, reject)
    }).then((res)=>{
      console.log(res);
    }).then(()=>{
      return new Promise((resolve, reject)=>{
        approve('部长', resolve, reject)
      })
    }).then((res)=>{
      console.log(res)
      console.log('执行流程相应操作')
    }).catch((err)=>{
      console.log(err)
      console.log('重新修改资料')
    })

    //如果是拒绝会向下查找最近一个处理拒绝的函数并执行它
  ```
  ### GreneratorFunction与Generator

  `GreneratorFunction`与Generator的关系就像function和object一样，Generator是用`GreneratorFunction`创建的，而`GreneratorFunction`的创建方法与function类似

  #### 创建

```javascript
function *GF(){}
  let GF1 = function *(){}
  let g = GF();
//GF和GF1都是GreneratorFunction, g是Generator
```

  #### 分段

每次调用next方法时，都会在yield所在的语句时暂停执行
在创建schedule时并不会执行Schedule的具体语句，所以start是在第一次调用方法时之后才打印出来的

```javascript
function *Schedule(){
  console.log('Start');
  let msg = '起床';
  yield console.log(msg);
  msg = '洗漱';
  yield console.log(msg);
  msg = '做饭';
  yield  console.log(msg);
  msg = '吃放';
  yield console.log(msg);
  msg = '上班';
  yield console.log(msg);
}

let schedule = Schedule();

schedule.next();
schedule.next();
schedule.next();
schedule.next();
```

  #### 参数和返回值

参数作为前一次yield语句的返回值，返回值是IteratorResult，包含value,done,
value表示yield语句的返回值，done表示GreneratorFunction是否执行完毕
false没有执行完毕，true执行完毕

```javascript
function *add(arg){
  let a = yield arg;
  console.log('a '+a);
  let b = yield a + arg;
  console.log('b '+b);
  let c = yield b + arg;
  console.log('c '+c);
}
```

```javascript
 let g1 = add(50);
  let r = g1.next();//参数会作为第一条yield的返回值，所以在最前一句的yield不需要参数
  console.log(JSON.stringify(r))
  r = g1.next(2);//参数作用在第一条yield上，也就是a 
  console.log(JSON.stringify(r))
  r = g1.next(20);
  console.log(JSON.stringify(r))
  r = g1.next(50);
  console.log(JSON.stringify(r))
```

  #### return和throw
    return 结束分段，返回value的iteratorResult
    throw抛出异常

### 反射与代理
  #### Reflect
    Reflect是反射对象，使用它可以不调用对象自身的方法来操作对象，Reflect不可以使用new关键字来创建实例对象，只可以用Reflect自身的方法来执行。Reflect对象公有14个方法

  - apply
    ```js
      Reflect.apply(target,thisArgument,argumentsList)

      //target是要执行的方法，thisArgument为this对象，argumentsList为方法的参数列表数组
    function add(num){
      return this.value + num;
    }
    let obj = {value: 10};
    console.log(Reflect.apply(add, obj, [7]))
    //将this设置成obj对象
    ```
  
  - construct
    ```js
      /*
        target function类型的对象
        argumentsList 创建对象时的参数
      */
      Reflect.construct(target,argumentsList);

      function Car(color){
        this.color = color;
      }
      let car = Reflect.construct(Car,'black');
      console.log(car.color)
    ```

  - ownKeys
    ```js
      Reflect.ownKeys(target) // 获取对象所有自身属性的属性名
    ```

  - defineProperty
    ```js
      //给指定对象定义一个属性
      Reflect.defineProperty(target, propertyKey, attributes)

      let obj = {name: 'peter'}
      Reflect.defineProperty(obj, 'age', {value: 21, enumerable: true})
    ```
  
  - deleteProperty
    ```js
      Reflect.deleteProperty(target, propertyKey) //删除属性
      //propertyKey : 属性
    ```
  
  - getOwnPropertyDescriptor
    ```js
      Reflect.getOwnPropertyDescriptor(target, propertyKey) //获取某个对象的某个属性的描述
    ```
  
  - getPrototypeOf 与 setPrototypeOf
    ```js
      Reflect.getPrototypeOf(target)//获取指定对象的prototyoe
      Reflect.setPrototypeOf(target)//设置指定对象的prototyoe
    ```
  
  - enumerate
  ```js
    Reflect.enumerate(target)//返回指定对象用于for-in的Iterator
  ```

  - has
  ```js
    Reflect.has(target, propertyKey)//检查指定对象是否包含某个属性
  ```

  - get 与 set
  ```js
    Reflect.get(target, propertyKey, V[, receiver])//获取指定对象的某个属性
    Reflect.set(target, propertyKey, V[, receiver])// 给指定对象的某个属性赋值
  ```

  - preventExtensions
    ```js
      Reflect.preventExtensions(target)//将指定对象设置为不可扩展
    ```

  - isExtensible
    ```js
      Reflect.isExtensible(target)//检查指定对象是否可扩展
    ```

  #### Proxy

Proxy是对象代理

```javascript
 new Proxy(targer, handler)
  //target是原始对象， hndler是处理器，代理的操作都写在这里，有14种属性代表14种操作，属性与Reflect完全一样

  function Box(x, y){
    this.x = x;
    this.y = y;
  }

  let box = new Box(1,2)
  let handler = {
    set(obj,key, val){
      console.log(`change ${key} to ${val}`)
      obj[key] = val
    }
  }

  let proxy = new Proxy(box, handler); //自动触发handler的set方法
  proxy.x = 10;
  console.log(proxy.x);
  console.log(box.x);
```

### Object.assign
  ```js
    //将 源对象的属性复制到目标对象，源对象可以有多个，以逗号隔开
    Object.assign(target, sources);
    //target 目标对象 sources 源对象

  ```

### `Object.getOwnPropertySymbols`
  ```js
    Object.getOwnPropertySymbols(object);//获取一个对象里所欲Symbol类型的属性名
  ```

### Object.is
  ```js
    Object.is(a,b)//判断类型，再判断是直接量还是对象，直接量再判断值，对象则判断是不是同一个对象
  ```

### WebSocket的优势
  - 避免频繁进行连接所带来的资源浪费
  - 实现真正的长连接，从而使服务器主动push数据变得非常简单
  - 可以节省宝贵的网络流量

### 节省网络流量的原因
  - 传输数据时不必在发送消息头
  - 服务端有需要推送的消息直接push，不需要客户再发送请求，相对于传统的轮训和长连接来说，就可以非常频繁的连接来说更是如此

```js
  let websocket = null;
  if('WebSocket' in window){
    websocket = new WebSocket("ws://127.0.0.1");
  }else{
    alert('浏览器不支持WebSocket')
  }

  //连接打开时调用
  websocket.onopen = function(event){
    //连接完成后的操作
  }

  //发送数据，可以通过程序调用，也可以绑定为某个节点的事件
  //例如可以绑定为发送按钮的click事件
  function sendMsg(msg){
    websocket.send(msg)
  }

  //接收数据
  websocket.onmessage = function(event){
    //通过event.data 接收数据
  }

  //处理异常
  websocket.onerror = function(event){

  }

  //关闭Socket
  function closeSocket(){
    websocket.close();
  }

  //关闭之后调用
  websocket.onclose = function(event){

  }
```

### 多线程
  ```js
     //要在服务端才能使用
    let restaurant = new Worker('restaurant.js');
    
    console.log(new Worker('restaurant.js'))

    function receive(event){
      console.log('下楼');
      console.log('拿外卖')
      console.log('上楼')
      console.log('吃')
    }

    restaurant.onmessage = receive; //绑定收获处理方法
    restaurant.addEventListener('message',receive)

    restaurant.onerror = function(event){
      console.log('出错')
    }

    console.log('订餐')
    restaurant.postMessage('卤面')
    

    //取消订单
    restaurant.terminate();

    let pageNum = 1;
    let reading = setInterval(()=>{
      if(pageNum>500){
        clearInterval(reading)
        console.log(pageNum++)
      }
    },100)
  ```

  