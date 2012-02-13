class Person
  constructor: (@name, @preferences) ->
    @mate = null
    @best_mate_rank = 0
    @rank = {}
    for preference, i in @preferences
      @rank[preference] = i
  
  preferred_mate_name: =>
    @preferences[@best_mate_rank]
    
  reject: =>
    @best_mate_rank += 1
    
  set_mate: (name) =>
    @mate = name
 
persons_by_name = (persons) ->
  hsh = {}
  for person in persons
    hsh[person.name] = person
  hsh
     
mate_off = (guys, gals) ->
  free_guys = (guy for guy in guys)
  guys_by_name = persons_by_name guys
  gals_by_name = persons_by_name gals

  while free_guys.length > 0
    free_guy = free_guys.shift()
    gal_name = free_guy.preferred_mate_name()
    gal = gals_by_name[gal_name]
    if gal.mate
      mate_name = gal.mate
      if gal.rank[mate_name] <= gal.rank[free_guy.name]
        console.log "#{free_guy.name} cannot steal #{gal.name} from #{mate_name}"
        free_guy.reject()
        free_guys.push free_guy
      else
        console.log "#{free_guy.name} steals #{gal.name} from #{mate_name}"
        old_mate = guys_by_name[mate_name]
        old_mate.reject()
        free_guy.set_mate gal_name
        gal.set_mate free_guy.name
        free_guys.push old_mate
    else
      console.log "#{free_guy.name} gets #{gal.name} first"
      free_guy.set_mate gal_name
      gal.set_mate free_guy.name
  
  for guy in guys
    console.log guy.name, guy.mate  

Population = ->
  guy_preferences =
   abe:  ['abi', 'eve', 'cath', 'ivy', 'jan', 'dee', 'fay', 'bea', 'hope', 'gay']
   bob:  ['cath', 'hope', 'abi', 'dee', 'eve', 'fay', 'bea', 'jan', 'ivy', 'gay']
   col:  ['hope', 'eve', 'abi', 'dee', 'bea', 'fay', 'ivy', 'gay', 'cath', 'jan']
   dan:  ['ivy', 'fay', 'dee', 'gay', 'hope', 'eve', 'jan', 'bea', 'cath', 'abi']
   ed:   ['jan', 'dee', 'bea', 'cath', 'fay', 'eve', 'abi', 'ivy', 'hope', 'gay']
   fred: ['bea', 'abi', 'dee', 'gay', 'eve', 'ivy', 'cath', 'jan', 'hope', 'fay']
   gav:  ['gay', 'eve', 'ivy', 'bea', 'cath', 'abi', 'dee', 'hope', 'jan', 'fay']
   hal:  ['abi', 'eve', 'hope', 'fay', 'ivy', 'cath', 'jan', 'bea', 'gay', 'dee']
   ian:  ['hope', 'cath', 'dee', 'gay', 'bea', 'abi', 'fay', 'ivy', 'jan', 'eve']
   jon:  ['abi', 'fay', 'jan', 'gay', 'eve', 'bea', 'dee', 'cath', 'ivy', 'hope']
 
  gal_preferences =
   abi:  ['bob', 'fred', 'jon', 'gav', 'ian', 'abe', 'dan', 'ed', 'col', 'hal']
   bea:  ['bob', 'abe', 'col', 'fred', 'gav', 'dan', 'ian', 'ed', 'jon', 'hal']
   cath: ['fred', 'bob', 'ed', 'gav', 'hal', 'col', 'ian', 'abe', 'dan', 'jon']
   dee:  ['fred', 'jon', 'col', 'abe', 'ian', 'hal', 'gav', 'dan', 'bob', 'ed']
   eve:  ['jon', 'hal', 'fred', 'dan', 'abe', 'gav', 'col', 'ed', 'ian', 'bob']
   fay:  ['bob', 'abe', 'ed', 'ian', 'jon', 'dan', 'fred', 'gav', 'col', 'hal']
   gay:  ['jon', 'gav', 'hal', 'fred', 'bob', 'abe', 'col', 'ed', 'dan', 'ian']
   hope: ['gav', 'jon', 'bob', 'abe', 'ian', 'dan', 'hal', 'ed', 'col', 'fred']
   ivy:  ['ian', 'col', 'hal', 'gav', 'fred', 'bob', 'abe', 'ed', 'jon', 'dan']
   jan:  ['ed', 'hal', 'gav', 'abe', 'bob', 'jon', 'col', 'ian', 'fred', 'dan']

  guys = (new Person(name, preferences) for name, preferences of guy_preferences)
  gals = (new Person(name, preferences) for name, preferences of gal_preferences)
  [guys, gals]
 
[guys, gals] = Population()
mate_off guys, gals
