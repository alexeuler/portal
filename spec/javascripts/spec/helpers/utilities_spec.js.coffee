describe "App.FieldExtractor", ->
        it "returns function that extracts field", ->
                test=
                name:
                        nested:1
                extractor=new App.FieldExtractor "name.nested"
                expect(extractor test).toEqual 1
        it "returns identity when name is empty, null or undefined", ->
                test=name: '1'
                expect((App.FieldExtractor())(test)).toEqual test
                expect((App.FieldExtractor(null))(test)).toEqual test
                expect((App.FieldExtractor(''))(test)).toEqual test
                
        it "throws String expected when name is not string", ->
                expect(-> App.FieldExtractor(new Object)).toThrow("String expected")

describe "App.CreateSort", ->
        it "sorts asc when only field is specified", ->
                sortFunc=App.CreateSort field:'name'
                list=[{name:"ab"},{name:"ba"},{name:"ac"}]
                sorted=list.sort(sortFunc).map (x)->x.name
                expect(sorted).toEqual ['ab','ac','ba']

        it "sorts desc when order is desc", ->
                list=[1,2,3]
                expect(list.sort(App.CreateSort order:'desc')).toEqual [3,2,1]
        it "accepts fileds separated by spaces and sorts by 1st field then by 2nd, etc.", ->
                sortFunc=App.CreateSort field:'name.last money'
                list=[]
                list.push
                        name:
                                last:'Karasev'
                                first:'Alexey'
                        money:100
                list.push
                        name:
                                last:'Goncharov'
                                first:'Dmitry'
                        money:200
                list.push
                        name:
                                last:'Goncharov'
                                first:'Andrey'
                        money:100
                list.push
                        name:
                                last:'Alexeev'
                                first:'Alexander'
                        money:400
                sorted=list.sort(sortFunc).map (x)->x.name.first
                expect(sorted).toEqual ['Alexander','Andrey','Dmitry','Alexey']
                

