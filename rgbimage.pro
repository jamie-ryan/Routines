pro rgbimage, rimg, gimg, bimg

thisDevice = !D.NAME
     SET_PLOT, 'Z'
     LOADCT, 5
     TVLCT, red, green, blue, /GET
     SET_PLOT, thisDevice

;Make sure the 2-D image data is scaled into the 256 colors. Next, create and fill up the 3D image array:
rim = BYTSCL(rimg)
gim = BYTSCL(gimg)
bim = BYTSCL(bimg)
s = SIZE(rim)
image3d = BYTARR(3, s(1), s(2))
image3d(0, *, *) = red(rim)
image3d(1, *, *) = green(gim)
image3d(2, *, *) = blue(bim)

WRITE_JPEG, 'myimage.jpg', image3d, TRUE=1, QUALITY=99
set_plot, 'x'
close, device
end
