NAME
====

Parameterizable - Make a class parameterizable

SYNOPSIS
========

```raku
use Parameterizable;

role Fooey[::Type] {
    method of() { Type }
}

class Foo is Parameterizable {
    method MIXIN(Mu:U \type) { Fooey[type] }
}

my $obj = Foo[Int].new;
say $obj.of; # OUTPUT: «(Int)␤»
```

DESCRIPTION
===========

    class Parameterizable is Mu {}

Roles can be parameterized, and in almost all cases such a role can be used as if it were a class because Raku supports [automatic role punning](https://docs.raku.org/language/objects#Automatic_role_punning). One unsupported use case is a method that assigns to the invocant, for example to support autovivification. If a type wants to support that, it must be a class. But classes are not parameterizable... or are they?

Class `Parameterizable` uses an undocumented Rakudo feature that allows classes to be parameterized. To support parameterization, a class may simply inherit from `Parameterizable` and define a method `MIXIN` that maps positional arguments to a role definition. The class can then be parameterized with arguments that are accepted by a `.MIXIN` candidate.

Class parameterization works by mixing in the role returned by `.MIXIN`. The parameterized class is given a name that includes the types of arguments it was parameterized with.

SEE ALSO
========

  * [Inconsistent dispatch to method defined in role](https://github.com/rakudo/rakudo/issues/4916)

AUTHOR
======

Peter du Marchie van Voorthuysen

Source can be located at: https://github.com/dumarchie/raku-parameterizable

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Peter du Marchie van Voorthuysen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

