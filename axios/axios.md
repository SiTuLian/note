### 跨域代理

- 在根目录下新建vue.config.js文件

```js
    module.exports = {
      devServer: {
        // 可配置多个代理
        proxy: {
          //替代的别名
          '/api': {
            target: 'http://123.207.32.32:8000/api/v1/',  //设置你调用的接口域名和端口号 别忘了加
            changeOrigin: true,
            pathRewrite: {
              '^/api': '',     //这里理解成用'/api'代替target里面的地址，后面组件中我们掉接口时直接用api          代替 比如我要调用'http://xxx.xxx.xxx.xx:8081/user/add'，直接写‘/api/user/add’即可
            }
          },
          //这里可以再写跨域代理的接口
        }
      }
    }
```

### axios的二次封装

```js
    import axios from 'axios'
    export function resquest(){
      const instance = axios.create({
        baseURL: '/api/',
        timeout: 10000
      });

      //请求拦截器
      instance.interceptors.request.use(config=>{
        return config
      }, err=>{
        console.log(err);
      })

      // 响应拦截
      instance.interceptors.response.use(res => {
        return res.data
      }, err =>{
        console.log(err);
      })

      return instance(config);
    }

```

### axios的基本操作

```js
  //默认为get请求
    resquest({
      url:'XXX',//链接
      method: 'post',//请求类型
      //如果接口拥有参数
      params: {
        id: 'XXXXX'//参数
      },
      // 如果请求为post，参数放在data里，请求为get，参数放在params
      data: {
        id: 'XXX'
      }
    }).then( res => {
      console.log(res)
    }).catch( err => {
      console.log(err)
    } )
```

### 并发请求

```js
    import axios from 'axios'
    axios.all([axios(), axios()]).then(res => {

    }).catch(err => {

    })

    //将结果单独拿出来
    axios.all([axios(), axios()])
      .then(axios.spread(res1,res2) => {
        console.log(res1,res2)
      })
    })
```

### axios的相关配置

- url 请求地址
- method 请求类型
- baseURL 请求跟路径
- transformRequest: function(data){} 请求前的数据处理
- transformResponse: function(data){} 请求后的数据处理
- headers 请求头
- params  get请求的参数
- paramsSerializer: function(params){} 查询对象序列化函数
- data  post请求的参数
- timeout  超时时间
- withCredentials: false 跨域是否带Token
- adapter: function(resolve, reject, config){} 自定义请求处理
- auth: {} 身份验证信息
- responseType 响应数据的信息



