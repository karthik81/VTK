# Test marching cubes speed
#
vtkVolume16Reader v16;
v16 SetDataDimensions 64 64;
[v16 GetOutput] SetOrigin 0.0 0.0 0.0;
v16 SwapBytesOn;
v16 SetFilePrefix "../../data/headsq/quarter";
v16 SetImageRange 1 93;
v16 SetDataAspectRatio 3.2 3.2 1.5;
v16 Update;

vtkContourFilter iso;
iso SetInput [v16 GetOutput];
iso SetValue 0 1150;

vtkCleanPolyData clean;
clean SetInput [iso GetOutput];

vtkPolyNormals normals;
normals SetInput [clean GetOutput];
normals Update;

exit;
