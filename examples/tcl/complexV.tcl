# get the interactor ui
source vtkInt.tcl
source "colors.tcl"
# First create the render master
vtkRenderMaster rm;

# Now create the RenderWindow, Renderer and both Actors
#
set renWin [rm MakeRenderWindow];
set ren1   [$renWin MakeRenderer];
set iren [$renWin MakeRenderWindowInteractor];

# create pipeline
#
vtkStructuredPointsReader reader;
    reader SetFilename "../../data/carotid.vtk"
    reader DebugOn;
vtkHedgeHog hhog;
    hhog SetInput [reader GetOutput];
    hhog SetScaleFactor 0.3;
vtkLookupTable lut;
#    lut SetHueRange .667 0.0;
    lut Build;
vtkPolyMapper hhogMapper;
    hhogMapper SetInput [hhog GetOutput];
    hhogMapper SetScalarRange 50 550;
    hhogMapper SetLookupTable lut;
vtkActor hhogActor;
    hhogActor SetMapper hhogMapper;

vtkOutlineFilter outline;
    outline SetInput [reader GetOutput];
vtkPolyMapper outlineMapper;
    outlineMapper SetInput [outline GetOutput];
vtkActor outlineActor;
    outlineActor SetMapper outlineMapper;
set outlineProp [outlineActor GetProperty];
#eval $outlineProp SetColor 0 0 0;

# Add the actors to the renderer, set the background and size
#
$ren1 AddActors outlineActor;
$ren1 AddActors hhogActor;
$ren1 SetBackground 1 1 1;
$renWin SetSize 500 500;
#$renWin SetSize 1000 1000;
$ren1 SetBackground 0.1 0.2 0.4;
$renWin DoubleBufferOff;
$iren Initialize;

# render the image
#
$iren SetUserMethod {wm deiconify .vtkInteract};
[$ren1 GetActiveCamera] Zoom 1.5;
$renWin Render;
#$renWin SetFilename "color11.ppm";
#$renWin SaveImageAsPPM;
puts "Done";

# prevent the tk window from showing up then start the event loop
wm withdraw .


