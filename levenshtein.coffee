levenshtein = (str1, str2) ->
  m = str1.length
  n = str2.length
  d = []

  return n  unless m
  return m  unless n


  i = 0
  while i <= m
    d[i] = [ i ]
    i++
  j = 0
  while j <= n
    d[0][j] = j
    j++
  j = 1
  while j <= n
    i = 1
    while i <= m
      if str1[i - 1] is str2[j - 1]
        d[i][j] = d[i - 1][j - 1]
      else
        d[i][j] = Math.min(d[i - 1][j], d[i][j - 1], d[i - 1][j - 1]) + 1
      i++
    j++
  d[m][n]

console.log levenshtein("kitten", "sitting")
console.log levenshtein("rosettacode", "raisethysword")