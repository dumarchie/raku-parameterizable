class Parameterizable is Mu {
    method ^parameterize(Mu:U \obj, **@pos is raw) {
        my \ROLE = try obj.MIXIN(|@pos);
        if $! {
            die "Can not parameterize {obj.^name} with "
              ~ @pos.map(*.raku).join(', ');
        }

        my $what := obj.^mixin(ROLE);
        $what.^set_name("{obj.^name}[{@pos.map(*.^name).join(',')}]");
        $what;
    }
}

=begin pod

=head1 NAME

Parameterizable - Make a class parameterizable

=head1 SYNOPSIS

=begin code :lang<raku>
use Parameterizable;

role Fooey[::Type] {
    method of() { Type }
}

class Foo is Parameterizable {
    method MIXIN(Mu:U \type) { Fooey[type] }
}

my $obj = Foo[Int].new;
say $obj.of; # OUTPUT: «(Int)␤»
=end code

=head1 DESCRIPTION

    class Parameterizable is Mu {}

Roles can be parameterized, and in almost all cases such a role can be used as
if it were a class because Raku supports L<automatic role
punning|https://docs.raku.org/language/objects#Automatic_role_punning>. One
unsupported use case is a method that assigns to the invocant, for example to
support autovivification. If a type wants to support that, it must be a class.
But classes are not parameterizable... or are they?

Class C<Parameterizable> uses an undocumented Rakudo feature that allows classes
to be parameterized. To support parameterization, a class may simply inherit
from C<Parameterizable> and define a method C<MIXIN> that maps positional
arguments to a role definition. The class can then be parameterized with
arguments that are accepted by a C<.MIXIN> candidate.

Class parameterization works by mixing in the role returned by C<.MIXIN>. The
parameterized class is given a name that includes the types of arguments it was
parameterized with.

=head1 SEE ALSO

=item L<Inconsistent dispatch to method defined in role|
https://github.com/rakudo/rakudo/issues/4916>

=head1 AUTHOR

Peter du Marchie van Voorthuysen

Source can be located at: https://github.com/dumarchie/raku-parameterizable

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Peter du Marchie van Voorthuysen

This library is free software; you can redistribute it and/or modify it under
the Artistic License 2.0.

=end pod
