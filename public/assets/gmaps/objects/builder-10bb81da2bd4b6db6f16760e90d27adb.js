(function() {
  this.Gmaps.Objects.Builders = function(builderClass, objectClass, primitivesProvider) {
    objectClass.PRIMITIVES = primitivesProvider;
    builderClass.OBJECT = objectClass;
    builderClass.PRIMITIVES = primitivesProvider;
    return {
      build: function(args, provider_options, internal_options) {
        var builder;
        builder = new builderClass(args, provider_options, internal_options);
        return builder.build();
      }
    };
  };

}).call(this);
