###SDGPostMan

#### 大概的架构流程
![](http://ocnhrgfjb.bkt.clouddn.com/WX20180920-163945.png)

###核心技术 `performTarget: action: params:`

##Usage

我将结合场景阐述一遍流程，帮助快速上手。

场景说明  

```
caller为使用者（调用responder的方法） 
SDGPostMan为中间件 （提供调度） 
responder 为响应者库（提供实现）
Name 为协议好的responder名称（区分各个responder，
一个responder库可以有一个或多个Name，对应的会存在一个或多个wrapper）
```
/*以下例子以每个responder库只建立一个warapper为背景*/

1、明确`responder`库需要对外开放的接口

2、在`responder`所在的pod（库）内建立一个以`NSObject`为父类，命名为`Target_Name`(`Target_`为固定前缀name为协商好的名称)的类。

3、在上面那个类中，`.h`中声明需要对外暴露的方法，命名规则为`Action_nativeMethodA`(`Action_native`为固定前缀 ,MethodA为自己定义的方法名 尽量做到看方法名就知道方法是干什么，必须用字典（因为PerformTarget:action只支持传递字典）作为入参)。然后在`.m`中直接调用`responder`内的其他类，来实现`.h`中暴露对外的方法。

4、然后再`SDGPostMan`这个pod(库)中建立一个名为`SDGPostMan+Name`（Name和responder库中的`Target_Name`的Name保持一致）的`SDGPostMan`的分类。

5、在`SDGPOstMan+Name.h`中对照`Target_Name.h`中的方法一一声明，但是方法名需要更改为`SDGPostMan_Name_自义方法名`(其中`SDGPostMan_`为固定前缀，加上Name_,机上自定义方法名)。

6、在`SDGPOstMan+Name.m`,在每个`SDGPOstMan+Name.h`中定义好的方法，通过调用`SDGPostMan`中的`performTarget: action: params:`无依赖的调用Responder的方法。 



![](http://ocnhrgfjb.bkt.clouddn.com//postman/WX20181018-165054.png)


## why and how
随着公司业务的不断发展，项目的功能越来越复杂，各个业务代码耦合也越来越多，代码量也是急剧增加，传统的MVC或者MVVM架构已经无法高效的管理工程代码，因此需要用一种技术来更好地管理工程，而组件化是一种能够解决代码耦合的技术。项目经过组件化的拆分，不仅可以解决代码耦合的问题，还可以增强代码的复用性，工程的易管理性等等。

####现有业界方案
#####1、url-block (代表：蘑菇街的MGJRouter方案 和比较多的大厂商解决 方案)

这是蘑菇街中应用的一种页面间调用的方式，通过在启动时注册组件提供的服务，把调用组件使用的url和组件提供的服务block对应起来，保存到内存中。在使用组件的服务时，通过url找到对应的block，然后获取服务。

架构图

![](http://ocnhrgfjb.bkt.clouddn.com//postman/PostMan1.png)

注册

``` obj-c
[MGJRouter registerURLPattern:@"mgj://detail?id=:id" toHandler:^(NSDictionary *routerParameters) {
    NSNumber *id = routerParameters[@"id"];
    // create view controller with id
    // push view controller
}];
```

调用

``` obj-c
[MGJRouter openURL:@"mgj://detail?id=404"]
```

蘑菇街为了统一iOS和Android的平台差异性，专门用后台来管理url，然后针对不同的平台，生成不同类型的文件，来方便使用。

使用url-block的方案的确可以实现组件间的解耦，但是还是存在其它明显的问题，比如：

1. 需要在内存中维护url-block的表，组件多了可能会有内存问题

2. url的参数传递受到限制，只能传递常规的字符串参数，无法传递非常规参数，如UIImage、NSData等类型

3. 没有区分本地调用和远程调用的情况，尤其是远程调用，会因为url参数受限，导致一些功能受限

4. （业务方）组件本身依赖了中间件，且分散注册使的耦合较多


#####2、protocol-class (代表蘑菇街组件化方案2.0 )
针对方案一的问题，蘑菇街又提出了另一种组件化的方案，就是通过protocol定义服务接口，组件通过实现该接口来提供接口定义的服务，具体实现就是把protocol和class做一个映射，同时在内存中保存一张映射表，使用的时候，就通过protocol找到对应的class来获取需要的服务。

架构图

![](http://ocnhrgfjb.bkt.clouddn.com//postman/Postman2.png)


注册：

``` obj-c
[ModuleManager registerClass:ClassA forProtocol:ProtocolA]
```

调用


``` obj-c
[ModuleManager classForProtocol:ProtocolA]
```


蘑菇街的这种方案确实解决了方案一中无法传递非常规参数的问题，使得组件间的调用更为方便，但是它依然没有解决组件依赖中间件的问题、内存中维护映射表的问题、组件的分散调用的问题。设计思想和方案一类似，都是通过给组件加了一层wrapper，然后给使用者调用。


### 3、target-action  SDGPostMan 解决方案

这个方案最早是和之前的同事一起搞出来的很轻量级的解决页面无依赖跳转的控件，后续发掘到这个方案的延伸性可以为组件化提供服务，加上偶然看见网上大神的casa的解决方案，虽没有过见面，但是想法竟然惊人的相似，又借鉴casa的解决方案优化了下给出了这个SDGPostMan。 
核心就是利用NSObject的
`- (id)performSelector:(SEL)aSelector withObject:(id)object;
`

方案是通过给组件包装一层wrapper来给外界提供服务，然后`调用者`通过依赖中间件来使用服务；其中，中间件是通过runtime来调用组件的服务，是真正意义上的解耦，也是该方案最核心的地方。具体实施过程是给组件封装一层target对象来对外提供服务，不会对原来组件造成入侵；然后，通过实现中间件的category来提供服务给`调用者`，这样`使用者`只需要依赖中间件，而组件则不需要依赖中间件。


###### 优缺点
1、没有任何注册问题，避免注册文件的维护和管理。Category给到的方法很明确地告知了调用者应该如何调用。

2、对老的代码没有任何侵入，所做的只是需要把需要暴露的方法，包装进wrapper暴露出来即可，另外一个非侵入性的特征体现在，基于SDGPostMan的组件化方案是可以循序渐进地实施的。这个方案的实施并不要求所有业务线都要被独立出来成为组件，实施过程也并不会修改未组件化的业务的代码。

3.命名域，响应者的命名域（调用方法依赖-wrapper）没有泄露到响应者意外的任何地方，这就带来一个好处，迁移方便。比如我们的响应者是一个上传组件。这个上传组件如果要替换的话，只需要在它外面包一个Target-Action，就可以直接拿来用了。而且包Target-Action的过程中，不会产生任何侵入性的影响。like USB，接口就是USB，我可以插任何支持USB接口的设备。

4.参数传递不受限。

5.唯一的缺点就是，组件化过程中，需要对响应者进行wrapper的开发，需要对响应者进行提炼，有一定的开发成本，但是一次开发终身使用。而且相较于动态注册的维护，前期复杂的wrapper开发解决后期维护，可以接受。




#### 大概的架构流程
![](http://ocnhrgfjb.bkt.clouddn.com/WX20180920-163945.png)

####具体实现可以参考demo
