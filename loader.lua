local loaders = {};

function createLoader(identificator, absX, absY, absW, absH, velocity, colors)
    assert(type(identificator) == "string", "Bad argument @ createLoader at argument 1, expect string got "..type(identificator));
    assert(type(absX) == "number", "Bad argument @ createLoader at argument 2, expect number got "..type(absX));
    assert(type(absY) == "number", "Bad argument @ createLoader at argument 3, expect number got "..type(absY));
    assert(type(absW) == "number", "Bad argument @ createLoader at argument 4, expect number got "..type(absW));
    assert(type(absH) == "number", "Bad argument @ createLoader at argument 5, expect number got "..type(absH));
    assert(type(velocity) == "number", "Bad argument @ createLoader at argument 6, expect number got "..type(velocity));
    assert(type(colors) == "table", "Bad argument @ createLoader at argument 7, expect table got "..type(colors));

    if not (loaders[identificator]) then
        loaders[identificator] = {
            id = identificator,
            x = absX,
            y = absY,
            w = absW,
            h = absH,
            velocity = velocity,
            assets = colors,
            show = true,
        };
        loaders[identificator].circle = svgCreate(loaders[identificator].w, loaders[identificator].h, [[
            <svg width="60" height="60">
                <path d="M60 30C60 46.5685 46.5685 60 30 60C13.4315 60 0 46.5685 0 30C0 13.4315 13.4315 0 30 0C46.5685 0 60 13.4315 60 30ZM9.99375 30C9.99375 41.0491 18.9509 50.0062 30 50.0062C41.0491 50.0062 50.0062 41.0491 50.0062 30C50.0062 18.9509 41.0491 9.99375 30 9.99375C18.9509 9.99375 9.99375 18.9509 9.99375 30Z" fill="white"/>
            </svg>
        ]])
        loaders[identificator].loader = svgCreate(loaders[identificator].w, loaders[identificator].h, [[
            <svg width="60" height="61">
                <path d="M59.9999 30.998C59.9999 36.1683 58.6636 41.2509 56.1208 45.7527C53.5779 50.2544 49.9148 54.0226 45.4866 56.6916L40.3276 48.1325C43.2806 46.3525 45.7235 43.8396 47.4193 40.8375C49.115 37.8354 50.0061 34.446 50.0061 30.998L59.9999 30.998Z" fill="white"/>
            </svg>
        ]])
    end

    local ld = loaders[identificator];

    if (ld.show) then
        dxSetBlendMode('add')
    
        dxDrawImage(ld.x, ld.y, ld.w, ld.h, ld.circle, 0, 0, 0, ld.assets.circle);
        dxDrawImage(ld.x, ld.y, ld.w, ld.h, ld.loader, (getTickCount() / (20 / ld.velocity)), 0, 0, ld.assets.loader);
    
        dxSetBlendMode('blend')
    end

end

function destroyLoader (id)
    assert(type(id) == "string", "Bad argument @ destroyLoader at argument 1, expect string got "..type(id));

    if not (loaders[id]) then
        return false;
    end
    loaders[id] = nil;
    return true;
end

function destroyAllLoaders ()
    for i, v in pairs(loaders) do
        loaders[i] = nil;
    end
end

function getAllLoaders ()
    local ld = {};
    for i, v in pairs(loaders) do
        table.insert(ld, #ld + 1, i);
    end
    return ld;
end

function setLoaderShowing (id, state)
    assert(type(id) == "string", "Bad argument @ setLoaderShowing at argument 1, expect string got "..type(id));

    if not (loaders[id]) then
        return false;
    end
    loaders[id].show = (state and state or not loaders[id].show);
    return true;
end

-- Exemple

addEventHandler('onClientRender', root, function ()
    createLoader('Test', 300, 300, 60, 60, 1, {circle = tocolor(200, 200, 200, 255), loader = tocolor(144, 14, 246, 255)});
    createLoader('Test2', 600, 300, 60, 60, 3, {circle = tocolor(200, 200, 200, 255), loader = tocolor(144, 14, 246, 255)});
end)

_dxDrawText = dxDrawText;
function dxDrawText (text, x, y, w, h, ...)
    return _dxDrawText(text, x, y, w + x, h + y, ...);
end