describe "CreateSort", ->
        it "sorts asc when only field lambda is specified", ->
                sortFunc=App.CreateSort field:(x)->x.name
                list=[{name:"ab"},{name:"ba"},{name:"ac"}]
                sorted=list.sort(sortFunc).map (x)->x.name
                expect(sorted).toEqualArray ['ab','ac','ba']

        it "sorts desc when order is desc", ->
                list=[1,2,3]
                expect(list.sort(App.CreateSort order:'desc')).toEqualArray [3,2,1]