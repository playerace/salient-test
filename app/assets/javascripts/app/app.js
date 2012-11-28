window.App = Ember.Application.create();

App.Contact = Ember.Object;
App.Contact = DS.Model.extend({
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
  contact_numbers: DS.hasMany('App.ContactNumber'),
  fullName: function() {
    return this.get('lastName') + ', ' + this.get('firstName');
  }.property('firstName', 'lastName')
}).reopenClass({
  url: '/contacts.json'
});

App.ContactNumber = Ember.Object;
App.ContactNumber = DS.Model.extend({
  number: DS.attr('number')
}).reopenClass({
  url: '/app/contacts/%@'
});


App.adapter = DS.Adapter.create({
  findAll: function (store, type) {
    var url = type.url;
    $.getJSON(url, function(data) {
      store.loadMany(type, data);
    });
  },
  find: function(store, type, id) {
    var url = type.url;
    url = url.fmt(id);

    jQuery.getJSON(url, function(data) {
      // data is a Hash of key/value pairs. If your server returns a
      // root, simply do something like:
      // store.load(type, id, data.person)
      store.loadMany(type, data);
    });
  }
});

App.store = DS.Store.create({
  revision: 8,
  adapter: App.adapter
});

App.contactsController = Ember.ArrayController.create({
  content: [],
  init: function(){
    this._super();
    this.set('content', App.store.findAll(App.Contact));
  }
});

App.contactnumbersController = Ember.ArrayController.create({
  content: [],
  init: function(){
    this._super();
    this.set('content', App.store.find(App.ContactNumber, 1));
  }
});
