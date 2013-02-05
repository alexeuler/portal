beforeEach ->
        @addMatchers
                toEqualArray:(arr1)->
                        arr2=this.actual
                        return false unless arr1.length is arr2.length
                        for i in [0...arr1.length]
                                return false unless arr1[i] is arr2[i]
                        true
                