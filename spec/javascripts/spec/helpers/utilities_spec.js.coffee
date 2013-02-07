describe "App.FieldExtractor", ->
        it "returns function that extracts field", ->
                test=
                name:
                        nested:1
                extractor=new App.FieldExtractor "name.nested"
                expect(extractor test).toEqual 1
        it "returns identity when name is empty, null or undefined", ->
                test=name: '1'
                expect((new App.FieldExtractor)(test)).toEqual test
                expect((new App.FieldExtractor(null))(test)).toEqual test
                expect((new App.FieldExtractor(''))(test)).toEqual test                

describe "App.CreateSort", ->
        it "sorts asc when only field lambda is specified", ->
                sortFunc=App.CreateSort field:(x)->x.name
                list=[{name:"ab"},{name:"ba"},{name:"ac"}]
                sorted=list.sort(sortFunc).map (x)->x.name
                expect(sorted).toEqualArray ['ab','ac','ba']

        it "sorts desc when order is desc", ->
                list=[1,2,3]
                expect(list.sort(App.CreateSort order:'desc')).toEqualArray [3,2,1]

