Type=Class
Version=3.5
@EndOfDesignText@
' Events declaration
#Event: CellClick

' Class module

' Creates a grid of labels
'  pass comma sep values in Tag property: rows,cols,border width

Sub Class_Globals
  Private mTarget As Object
  Private mEventName As String
  Private w, h, r, c, nr, nc, bdrw As Int
  
  Public lblst As List
  Public pnl As Panel
  Public hdg, val As Label
End Sub

Public Sub Initialize (TargetModule As Object, EventName As String)
  mTarget = TargetModule
  mEventName = EventName
End Sub

Public Sub DesignerCreateView(Base As Panel, lbl As Label, Props As Map)
  Dim s, sa() As String
  
  pnl = Base
  
  lblst.Initialize
  
  s = lbl.Tag
  sa = Regex.Split(",", s)
  
  If (sa.Length <> 3) Then
    nr = 2
    nc = 2
    bdrw = 2
  Else
    nr = sa(0)
    nc = sa(1)
    bdrw = sa(2)
  End If
  
  For i=0 To nr*nc-1
    Dim lb As Label
    lb.Initialize("CellClk")
    lblst.Add(lb)
    
    pnl.AddView(lb, bdrw, bdrw, 10dip, 10dip)

	lb.TextSize = lbl.TextSize
    lb.TextColor = lbl.TextColor
    lb.Gravity = lbl.Gravity
    lb.Text = lbl.Text
    lb.Typeface = lbl.Typeface
  Next
End Sub

Public Sub SetLabelPos
  Dim lb As Label
  
  w = (pnl.Width - (nc + 1) * bdrw) / nc 
  h = (pnl.Height - (nr + 1) * bdrw) / nr 

  For i=0 To lblst.Size-1
    r = Floor(i / nc)
    c = i Mod nc
    
    lb = lblst.get(i)
    
    lb.SetLayout(bdrw + c * (w + bdrw), bdrw + r * (h + bdrw), w, h)
  Next
End Sub
