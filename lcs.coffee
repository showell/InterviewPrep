lcs = (s1, s2) ->
  len1 = s1.length
  len2 = s2.length
  
  # Initialize edges of matrix
  m = []
  m[i] = [''] for i in [0..len1]
  for j in [1..len2]
    m[0][j] = ''

  for i in [0...len1]
    for j in [0...len2]
      if s1[i] == s2[j]
        s = m[i][j] + s1[i]
        m[i+1][j+1] = s
      else
        ss1 = m[i+1][j]
        ss2 = m[i][j+1]
        if ss1.length > ss2.length
          ss = ss1
        else
          ss = ss2
        m[i+1][j+1] = ss
  m[len1][len2]
    


s1 = "thisisatest"
s2 = "testing123testing"
console.log lcs(s1, s2)