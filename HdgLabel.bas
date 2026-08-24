Type=Class
Version=3.5
@EndOfDesignText@
' Events declaration
' #Event: SingleClick

' Class module

Sub Class_Globals
  Private mTarget As Object
  Private mEventName As String
  Public pnl As Panel
  Public hdg, val As Label
End Sub

Public Sub Initialize (TargetModule As Object, EventName As String)
  mTarget = TargetModule
  mEventName = EventName
End Sub

Public Sub DesignerCreateView(Base As Panel, lbl As Label, Props As Map)
  Dim h As Int
  
  pnl = Base
'  pnl.Color = Colors.ARGB(255, 248, 248, 255)
  
  hdg.Initialize("")
  val.Initialize("")
  
  h = Base.Height * 0.33

  Base.AddView(hdg, 0, 0, Base.Width, h)
  hdg.TextSize = lbl.TextSize * 0.7
  hdg.TextColor = Colors.Gray
  hdg.Gravity = lbl.Gravity
  hdg.Text = lbl.Text
  hdg.Typeface = lbl.Typeface
  
  Base.AddView(val, 0, h, Base.Width, Base.Height - h)
  val.TextSize = lbl.TextSize
  val.TextColor = lbl.TextColor
  val.Gravity = lbl.Gravity
  val.Text = lbl.Text
  val.Typeface = lbl.Typeface
End Sub
