if (Meteor.isClient) {
  Template.hello.helpers({
    dataContext: function () {
      return {
        dataContextHelper: function () {
          console.log('dataContextHelper', arguments);
          return "dataContextHelper WORKS";
        },

        dataContextTemplate: function () {
          console.log('dataContextTemplate', arguments);
          return Template.works;
        }
      };
    }
  });
}
