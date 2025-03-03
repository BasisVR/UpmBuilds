# Generator.Equals

The Generator.Equals library from nuget!

## Oddities of this package

The generator has two parts: the roslyn source generator part, and the runtime
library. The source generator runs only at build time and also has a dependency
on the runtime library. The runtime library runs both at build time and at
regular runtime.

The runtime lib uses [`System.HashCode`][System.HashCode] which is included in
netstandard2.1, but requires the `Microsoft.Bcl.HashCode` package when
targetting netstandard2.0 (i.e. it is present in netstandard2.0 but
"package-provided").

Because unity already supports netstandard2.1, it was preferable to build the
runtime lib against netstandard2.1 instead of vendoring
`Microsoft.Bcl.HashCode`. However, roslyn source generators [*must* be built
against netstandard2.0][roslyn-requires-netstandard20]...

To work around this, and avoid needing to vendor `Microsoft.Bcl.HashCode`, we
build the package twice: Once we build *both* the source generator and the
runtime against netstandard2.0, and the second time we build *only* the runtime
against netstandard2.1. To accomplish the second build, we `git apply` a patch
to enable netstandard2.1 and remove the unneded dependency, and then `dotnet
build`.

Finally to get the source generator to work in Unity, we follow the [official
docs][source-generator-unity-docs], in particular we disable all target
platforms and give it an asset label of `RoslynAnalyzer`, but only for the
source generator. The runtime dll doesn't get this label and has support for
all platforms.

[System.HashCode]: https://learn.microsoft.com/en-us/dotnet/api/system.hashcode?view=net-9.0
[roslyn-requires-netstandard20]: https://github.com/dotnet/roslyn/issues/45162 
[source-generator-unity-docs]: https://docs.unity3d.com/Manual/install-existing-analyzer.html
