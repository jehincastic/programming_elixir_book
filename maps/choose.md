Ask yourself these questions (in this order):

  1. Do I want to pattern-match against the contents (for example, matching a dictionary that has a key of :name somewhere in it)?
  If so, use a map.
  
  2. Will I want more than one entry with the same key?
  If so, you’ll have to use the Keyword module.

  3. Do I need to guarantee the elements are ordered?
  If so, again, use the Keyword module.

  4. Do I have a fixed set of fields (that is, is the structure of the data always the same)?
  If so, use a struct.

  5. Otherwise, if you’ve reached this point,
  Use a map.
