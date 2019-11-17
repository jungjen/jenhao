should = require 'should'
MongoDB=require '../server/mongodb'

describe '#mongodb',=>

    before ->
        new  MongoDB database:'test',(db)

        

    after ->
        db.disconnect()
        

    it 'return 1+1 = 2',=>
        (1+1 is 2).should.be.true
    
    it 'return 1+1 = 2',=>
        (1+1 is 2).should.be.true

