<?php

# You must configure bk_connect.pl to connect with
# your database.
#
# You must also set up the bk_code table schema
# and load at least the core bk_code records before
# this will run.  The native language must be English.

print "1..25\n";

function ok($got, $expect = 'NO SECOND ARG') {
    global $counter;
    $counter++;
    if ($expect === 'NO SECOND ARG') {
        if ($expect) {
            print "ok $counter\n";
        } else {
            print "not ok $counter\n";
        }
    } else {
        if ( $got == $expect ) {
            print "ok $counter\n";
        } else {
            print "not ok $counter\n";
            print "# Test $counter got: '$got'\n";
            print "#   Expected: '$expect'\n";
        }
    }
}

require_once('../bk_connect.inc');
require_once("../BabelKit.php");
ok(1);

$dbh = bk_connect();
ok(1);

$bkh = new BabelKit($dbh);
ok(1);

# Clean up old data.
$bkh->remove('regression',  1);
$bkh->slave('regression', '2', NULL);
$bkh->put('regression', 'en', 3, NULL);
ok(1);

# Test basic puts.
$bkh->put('regression', 'en',  1, 'Monday', NULL);
$bkh->put('regression', 'en', '2', 'Tuesday', '');
$bkh->put('regression', 'fr', '2', 'mardi', 3, 'd');
ok(1);

# And gets.

ok( join(',', $bkh->get('regression', 'en', '1')), 'Monday,1,' );
ok( join(',', $bkh->get('regression', 'en',  2 )), 'Tuesday,2,' );
ok( join(',', $bkh->get('regression', 'fr',  2 )), 'mardi,0,' );

# Simple select.
$expect = '<select name="regression">
<option value="" selected>Coffee Date?
<option value="1">Monday
<option value="2">Mardi
</select>
';
ok( $bkh->select('regression', 'fr', array(
                 select_prompt => 'Coffee Date?'
                 )), $expect );

# Slave & desc methods.
$bkh->slave('regression', '3', 'wednes day');
ok( join(',', $bkh->get('regression', 'en', 3)), 'wednes day,3,' );
ok( $bkh->desc('regression', 'fr', 3),           'wednes day' );
ok( $bkh->ucfirst('regression', 'fr', 3),        'Wednes day' );
ok( $bkh->ucwords('regression', 'fr', 3),        'Wednes Day' );
ok( $bkh->desc('regression', 'fr', 2),           'mardi' );
ok( $bkh->render('regression', 'fr', 3),         'wednes day' );
ok( $bkh->data('regression', 'en', 3),           'wednes day' );
ok( $bkh->data('regression', 'fr', 3),           '' );
ok( $bkh->param('regression', 3),                'wednes day' );
$bkh->slave('regression', '3', 'Wednesday');
ok( join(',', $bkh->get('regression', 'en', 3)), 'Wednesday,3,' );


# Select options.
$expect = '<select name="regression_test">
<option value="">(None)
<option value="1">Monday
<option value="2" selected>Mardi
</select>
';
ok( $bkh->select('regression', 'fr', array(
                var_name     => 'regression_test',
                subset       => array( 1, '2' ),
                value        => '2',
                blank_prompt => '(None)'
                )), $expect );

# Radiobox options.
$expect = '<input type="radio" name="rt" value="">(None)<br>
<input type="radio" name="rt" value="1">Monday<br>
<input type="radio" name="rt" value="2" checked>Mardi';
ok( $bkh->radio('regression', 'fr', array(
                var_name     => 'rt',
                subset       => array( 1, '2' ),
                'default'    => '2',
                blank_prompt => '(None)'
                )), $expect);

# Select multiple options.
$expect= '<select multiple name="reg_test[]" size="10">
<option value="1">Monday
<option value="2" selected>Mardi
<option value="3" selected>Wednesday
</select>
';
ok( $bkh->multiple('regression', 'fr', array(
                var_name => 'reg_test',
                subset   => array( 1, '2', 3 ),
                value    => array( '2', 3 ),
                size     => 10
                )), $expect);

# Checkbox options.
$expect = '<input type="checkbox" name="checkbox_test[]" value="1" checked>Monday<br>
<input type="checkbox" name="checkbox_test[]" value="2">Mardi<br>
<input type="checkbox" name="checkbox_test[]" value="3" checked>Wednesday';
ok( $bkh->checkbox('regression', 'fr', array(
                var_name => 'checkbox_test',
                subset   => array( 1, '2', 3 ),
                value    => array( '1', 3 ),
                )), $expect);

# Clean up the test data.
$bkh->remove('regression',  1);
$bkh->slave('regression', '2', '');
$bkh->put('regression', 'en', 3, '');
ok(1);

$rows = $bkh->full_set('regression', 'fr');
ok(count($rows), 0);

