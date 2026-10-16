import 'package:test/test.dart';
import 'package:viem_dart_tooling/src/licence_policy.dart';

const _mit = '''
MIT License

Copyright (c) 2026 Someone

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction.

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
''';

const _mit0 = '''
MIT No Attribution

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction.
''';

const _bsdBody = '''
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
''';

const _bsd3Clause = '''
3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.
''';

const _apache = '''
                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/
''';

const _isc = '''
Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.
''';

const _zeroBsd = '''
Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.
''';

// Deliberate probes: the real headers of the denied licences.
const _gpl = '''
                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007
''';
const _lgpl = '''
                   GNU LESSER GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007
''';
const _agpl = '''
                    GNU AFFERO GENERAL PUBLIC LICENSE
                       Version 3, 19 November 2007
''';
const _mpl = '''
Mozilla Public License Version 2.0
==================================
''';

void main() {
  group('classifyLicenceText', () {
    test('recognises each allowed licence', () {
      expect(classifyLicenceText(_mit), {'MIT'});
      expect(classifyLicenceText(_mit0), {'MIT-0'});
      expect(classifyLicenceText(_bsdBody), {'BSD-2-Clause'});
      expect(classifyLicenceText(_bsdBody + _bsd3Clause), {'BSD-3-Clause'});
      expect(classifyLicenceText(_apache), {'Apache-2.0'});
      expect(classifyLicenceText(_isc), {'ISC'});
      expect(classifyLicenceText(_zeroBsd), {'0BSD'});
      expect(
        classifyLicenceText(
          'This is free and unencumbered software released into the public domain.',
        ),
        {'Unlicense'},
      );
      expect(classifyLicenceText('CC0 1.0 Universal'), {'CC0-1.0'});
    });

    test('is insensitive to line wrapping and case', () {
      expect(classifyLicenceText(_mit.toUpperCase().replaceAll('\n', '\n  ')), {
        'MIT',
      });
    });

    test('recognises each denied licence', () {
      expect(classifyLicenceText(_gpl), {'GPL'});
      expect(classifyLicenceText(_lgpl), {'LGPL'});
      expect(classifyLicenceText(_agpl), {'AGPL'});
      expect(classifyLicenceText(_mpl), {'MPL-2.0'});
      expect(classifyLicenceText('Server Side Public License, v 1'), {'SSPL'});
      expect(classifyLicenceText('Business Source License 1.1'), {'BUSL'});
    });

    test('finds nothing in a text it does not know', () {
      expect(classifyLicenceText('All rights reserved. Do not copy.'), isEmpty);
      expect(classifyLicenceText(''), isEmpty);
    });
  });

  group('verdictFor', () {
    test('allows a set made only of allowed licences', () {
      expect(verdictFor({'MIT'}), LicenceVerdict.allowed);
      expect(verdictFor({'MIT', 'BSD-3-Clause'}), LicenceVerdict.allowed);
    });

    test(
      'denies a set that holds a denied licence, even beside an allowed one',
      () {
        expect(verdictFor({'GPL'}), LicenceVerdict.denied);
        expect(verdictFor({'MIT', 'GPL'}), LicenceVerdict.denied);
        expect(verdictFor({'MPL-2.0'}), LicenceVerdict.denied);
      },
    );

    test('leaves an empty set unclassified, never allowed', () {
      expect(verdictFor({}), LicenceVerdict.unclassified);
    });

    test('keeps the allow and deny lists disjoint', () {
      expect(allowedLicences.intersection(deniedLicences), isEmpty);
    });
  });
}
