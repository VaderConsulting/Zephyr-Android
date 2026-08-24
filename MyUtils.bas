Type=StaticCode
Version=3.5
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

' ArrMin, ArrMax
' UpdHtmlSrc, LogView
' LetToStr, MapToStr, StrExplode, StrToMap
' Sprintf, TRepl

Sub ArrSum(v() As Int, k As Int) As Int
  Dim i, sum As Int
  
  If ((k < 0) OR (k > v.Length-1)) Then Return(0)
  
  sum = 0
  
  For i=0 To k
    sum = sum + v(i)
  Next
  
  Return(sum)  
End Sub

Sub ArrMin(v() As Int) As Int
  Dim i, m As Int
  
  If (v.Length < 1) Then Return(0)
  
  m = v(0)
  
  For i=1 To v.Length-1
    If (v(i) < m) Then m = v(i)
  Next
  
  Return(m)  
End Sub

Sub ArrMax(v() As Int) As Int
  Dim i, m As Int
  
  If (v.Length < 1) Then Return(0)
  
  m = v(0)
  
  For i=1 To v.Length-1
    If (v(i) > m) Then m = v(i)
  Next
  
  Return(m)  
End Sub

Sub StrToMap(str As String, mp As Map)
  Dim i, j, k As Int
  Dim t, U, mk, mv As String
  
  If (mp.IsInitialized = False) Then mp.Initialize
  mp.Clear
  t = str
  i = 0
  
  Do While (i < str.Length)
    t = t.SubString(i)
	
    j = t.IndexOf(";")
	If (j >= 0) Then
	  i = j + 1
	  U = t.SubString2(0, j)
	  U = U.Trim
	Else
	  i = str.Length + 1
	  U = t.Trim
	End If
	
	j = U.IndexOf("=")
	If (j >= 0) Then
	  mk = U.SubString2(0, j)
	  mk = mk.Trim
	  mv = U.SubString(j+1)
	  mv = mv.Trim
	End If
	
	If ((mk.Length > 0) AND (mv.Length > 0)) Then
	  mp.Put(mk, mv)
	End If
  Loop
End Sub

Sub MapToStr(mp As Map) As String
  Dim i As Int
  Dim s, t, k, v As String
  
  t = ""
  
  For i=0 To mp.Size-1
    s = mp.GetKeyAt(i)
	v = mp.GetValueAt(i)
	
	s = Sprintf("%s=%s", Array As Object(s, v))
	If (t.Length = 0) Then
	  t = s
	Else
	  t = Sprintf("%s;%s", Array As Object(t, s))
	End If
  Next
  
  Return(t)
End Sub

Sub LstToStr(ls As List) As String
  Dim i As Int
  Dim s As String
  
  s = ""
  
  For i=0 To ls.Size-1
    If (i > 0) Then s = s & ", "
	s = s & ls.Get(i)
  Next
  
  Return(s)
End Sub

Sub StrExplode(str As String, lc As List)
  Dim i, j, k As Int
  Dim t, U, mk, mv As String
  
  If (lc.IsInitialized = False) Then lc.Initialize
  lc.Clear
  t = str
  i = 0
  
  Do While (i < str.Length)
    t = t.SubString(i)
	
    j = t.IndexOf(",")
	If (j >= 0) Then
	  i = j + 1
	  U = t.SubString2(0, j)
	  U = U.Trim
	Else
	  i = str.Length + 1
	  U = t.Trim
	End If
	
	If (U.Length > 0) Then
	  lc.Add(U)
	End If
  Loop
End Sub

Sub UpdHtmlSrc(shtm As String, sd As String) As String ' add img path
  Dim i, j, k0, k1, k2 As Int
  Dim s, t0, t1, t2, t3 As String
  
  s = shtm
  i = 0
  
  Do While (i >= 0)
    i = s.IndexOf2("<img", i)
	
	If (i < 0) Then
	  Return(s)
	Else
	  j = s.IndexOf2(">", i) + 1
	  
	  If (j > i) Then
	    t0 = s.SubString2(0, i)
	    t1 = s.SubString2(i, j)
		t2 = s.SubString(j)
		i = i + 1
		
		k0 = t1.IndexOf("src=")
		If (k0 < 0) Then Return(s)

		k1 = t1.IndexOf2(QUOTE, k0) + 1
		k2 = t1.IndexOf2(QUOTE, k1)
		t3 = t1.SubString2(k1, k2)
		t1 = t1.Replace(t3, sd & t3)
		
		s = t0 & t1 & t2
	  End If
	End If
  Loop
  
  Return(s)  
End Sub

Sub TRepl(txt As String) As String
  Dim s As String
  
  s = txt
  
  s = s.Replace("\n", Chr(10))
  s = s.Replace("\r", Chr(13))
  s = s.Replace("\t", Chr(9))

  Return(s)
End Sub

Sub LogView(nam As String, pnl As Panel)
  Log(nam & ":")
  Log("  " & "Left: " & pnl.Left)
  Log("  " & "Top: " & pnl.Top)
  Log("  " & "Width: " & pnl.Width)
  Log("  " & "Height: " & pnl.Height)
End Sub

Sub Sprintf(fmt As String, arg() As Object) As String
  Dim ai, fi, i, j As Int
  Dim exp, wid As Int
  Dim stmp, ptmp, sres, c, s, t As String
  Dim bdone As Boolean
  
  ai = 0
  fi = 0
  stmp = ""
  sres = ""
  
  Do While (fi < fmt.Length)
    c = fmt.CharAt(fi)
    fi = fi + 1
	
    If (c = "%") Then
	  stmp = ""
	  ptmp = ""
	  bdone = False
	  
      Do While ((fi < fmt.Length) AND (bdone = False))
        c = fmt.CharAt(fi)
		fi = fi + 1
		
	    If (c = "%") Then
          sres = sres & c
		  bdone = True
	    Else If ((IsNumber(c) = True) OR (c = ".")) Then
		  ptmp = ptmp & c
		  bdone = False
		Else If (c = "s") Then
		  stmp = arg(ai)
		  ai = ai + 1
		  sres = sres & stmp
		  bdone = True
		Else If (c = "d") Then
		  If (ptmp.Length > 0) Then
		    t = " "
			If (ptmp.CharAt(0) = "0") Then
			  t = "0"
			  ptmp = ptmp.SubString(1)
			End If
		  End If
		  
		  If (ptmp.Length > 0) Then wid = ptmp Else wid = 0
		  
		  stmp = arg(ai)
		  
		  Do While (stmp.Length < wid)
		    stmp = t & stmp
		  Loop
		  
		  ai = ai + 1
		  sres = sres & stmp
		  bdone = True
		Else If (c = "f") Then
		  If (ptmp.Length > 0) Then
		    i = ptmp.IndexOf(".")
		    If (i >= 0) Then
			  wid = ptmp.SubString2(0, i)
			  exp = ptmp.SubString(i+1)
			Else
			  wid = ptmp
			  exp = 0
			End If
		    
			stmp = NumberFormat(arg(ai), wid, exp)
		  Else
		    stmp = arg(ai)
		  End If

		  ai = ai + 1
		  sres = sres & stmp
		  bdone = True
		Else
		  ai = ai + 1
		End If
		
	  Loop
	Else
	  sres = sres & c
	End If
  Loop
  
  Return(sres)
End Sub

