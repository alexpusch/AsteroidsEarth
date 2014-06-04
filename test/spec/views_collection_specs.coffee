define ['views_collection'], (ViewsCollection) ->
  describe "ViewsCollection", ->
    describe "render", ->
      it "renders the views by thier z index", ->
        @viewsCollection = new ViewsCollection()

        view1 = {rendered: false}
        view2 = {rendered: false}
        view3 = {rendered: false}

        orderWasPreserved = true

        view1.render = jasmine.createSpy().andCallFake ->
          view1.rendered = true

        view2.render = jasmine.createSpy().andCallFake ->
          unless view1.rendered
            orderWasPreserved = false

          view2.rendered = true

        view3.render = jasmine.createSpy().andCallFake ->
          unless view2.rendered
            orderWasPreserved = false

          view3.rendered = true

        @viewsCollection.add "view2", view2, 1
        @viewsCollection.add "view1", view1, -1
        @viewsCollection.add "view3", view3, 3

        @viewsCollection.render()

        expect(orderWasPreserved).toBeTruthy()
