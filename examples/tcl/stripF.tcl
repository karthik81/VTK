# this is a tcl version of old spike-face
# get the interactor ui
source vtkInt.tcl
# First create the render master
#
vtkRenderMaster rm;

# Now create the RenderWindow, Renderer and both Actors
#
set renWin [rm MakeRenderWindow];
set ren1   [$renWin MakeRenderer];
set iren [$renWin MakeRenderWindowInteractor];

# create a cyberware source
#
vtkCyberReader cyber;
    cyber SetFilename "../../data/fran_cut"
    cyber DebugOn;
vtkPolyNormals normals;#enable this for cool effect
    normals SetInput [cyber GetOutput];
    normals FlipNormalsOn;
    normals DebugOn;
vtkStripper stripper;
    stripper SetInput [cyber GetOutput];
    stripper DebugOn;
vtkMaskPolyData mask;
    mask SetInput [stripper GetOutput];
    mask SetOnRatio 2;
vtkPolyMapper cyberMapper;
    cyberMapper SetInput [mask GetOutput];
vtkActor cyberActor;
    cyberActor SetMapper cyberMapper;
eval [cyberActor GetProperty] SetColor 1.0 0.49 0.25;

# Add the actors to the renderer, set the background and size
#
$ren1 AddActors cyberActor;
$ren1 SetBackground 1 1 1;
$renWin SetSize 750 750;
#$ren1 SetBackground 0.1 0.2 0.4;
$ren1 SetBackground 1 1 1;

# render the image
#
vtkCamera cam1;
  cam1 SetFocalPoint 0.0520703 -0.128547 -0.0581083;
  cam1 SetPosition 0.419653 -0.120916 -0.321626;
  cam1 CalcViewPlaneNormal;
  cam1 SetViewAngle 21.4286;
  cam1 SetViewUp -0.0136986 0.999858 0.00984497;
$ren1 SetActiveCamera cam1;
$iren SetUserMethod {wm deiconify .vtkInteract};
$iren Initialize;
$renWin Render;

# prevent the tk window from showing up then start the event loop
wm withdraw .




