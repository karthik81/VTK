# this is a tcl version of the Mace example
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

# create a sphere source and actor
#
vtkSphereSource sphere;

# create the spikes using a cone source and the sphere source
#
vtkVectorText text;
set count 3;
text SetText "Welcome to VTK
An exciting new adventure 
brought to you by over 
$count monkeys at work for 
over three years.";

vtkShrinkPolyData shrink;
shrink SetInput [text GetOutput];
shrink SetShrinkFactor 0.1;

vtkPolyMapper spikeMapper;
    spikeMapper SetInput [shrink GetOutput];
vtkLODActor spikeActor;
    spikeActor SetMapper spikeMapper;

# Add the actors to the renderer, set the background and size
#
$ren1 AddActors spikeActor;
$ren1 SetBackground 0.1 0.2 0.4;
$renWin SetSize 800 800;
set cam1 [$ren1 GetActiveCamera];
$cam1 Zoom 1.4;

for {} {$count < 27} {} {
   $renWin Render;
   set count [expr $count+1];
   shrink SetShrinkFactor [expr $count / 27.0]; 
text SetText "Welcome to VTK
An exciting new adventure 
brought to you by over 
$count monkeys at work for 
over three years.";
}

# render the image
#
$iren SetUserMethod {wm deiconify .vtkInteract};
$iren Initialize;

# prevent the tk window from showing up then start the event loop
wm withdraw .
