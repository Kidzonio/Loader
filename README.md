# How to create a Loader?

```lua
createLoader('Identificator',
absPositionX,
absPositionX,
absWidth,
absHeight,
velocity,
{
    circle = tocolor(R, G, B, A),
    loader = tocolor(R, G, B, A),
}
)
```

![Preview](https://github.com/Kidzonio/Loader/blob/main/loader.png)

# Loader Functions

* #### Destroy a Loader

```lua
destroyLoader('Identificator');
```

* #### Destroy all Loaders

```lua
destroyAllLoaders();
```

* #### Get all Loaders

```lua
getAllLoaders();
```

* #### Show a Loader

```lua
setLoaderShowing('Identificator', state) -- If done this way, the Loader will receive the value passed.

-- or

setLoaderShowing('Identificator') -- If done this way, the Loader will receive the opposite value to what it was before.
```