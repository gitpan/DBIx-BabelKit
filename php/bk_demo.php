<?php

#       #       #       #
#
# bk_demo.php
#
# BabelKit Universal Multilingual Code HTML select function PHP demo page.
#
# Copyright (C) 2003 John Gorman <jgorman@webbysoft.com>
# http://www.webbysoft.com/babelkit
#

bk_demo();

function bk_demo() {

    require_once('bk_connect.inc');
    $dbh = bk_connect();

    require_once('BabelKit.php');
    $babelkit = new BabelKit($dbh);

    $title = "BabelKit Multilanguage Code Select PHP Demo";
    print "
    <html>
    <head>
    <title>$title</title>
    </head>

    <body text=\"#000044\" bgcolor=\"#f0ffff\"
    link=\"#0000cc\" vlink=\"#0066ff\" alink=\"#ffcc00\">

    <center>
    <table border=\"1\" width=\"600\" cellpadding=\"20\">
    <tr>
    <td>

    <h2 style=\"color:#873852\">$title</h2>

    <a href=\"http://www.webbysoft.com/babelkit\">BabelKit</a> -
    Interface to a universal multilingual code table.

    <p>
    The codified values stored in database fields are not
    language sensitive.  However, web pages and other documents
    often need to display the code descriptions in various
    languages.
    
    <p>
    BabelKit makes this a snap to program.  You can see
    the PHP method calls to BabelKit that produce these
    multilingual HTML select elements.

    <p>
    This page shows off the BabelKit code select functions.
    Select another language for the code description display.
    Select various combinations of countries and months then
    click [Test BabelKit] at the bottom.

    <p>
    Have fun!

    </td></tr><tr><td>
    <form action=\"" . $_SERVER['PHP_SELF'] . "\" method=\"post\">
    ";

    #
    # Select Display Language.
    #

    $display_lang = $_POST['display_lang'];
    print "<b>Select another display language!</b>
    <p>Specify the variable name as 'display_lang'.
    <br>Pass in the native language as the default value.
    <pre>
print \$babelkit->select('code_lang', \$display_lang, array(
                         var_name  =&gt; 'display_lang',
                         'default' =&gt; \$babelkit-&gt;native
));
    </pre>
    \$display_lang is '$display_lang':
    <p>
    ";
    print $babelkit->select('code_lang', $display_lang, array(
                            var_name  => 'display_lang',
                            'default' => $babelkit->native
    ));

    #
    # Currency Dropdown.
    #

    $mycurrency = $_POST['currency'];
    print "</td></tr><tr><td>
    <b>Select a currency.</b>
    <p>Pass in a specific code value.
    <pre>
print \$babelkit->select('currency', \$display_lang, array(
                         value =&gt; \$mycurrency
));
    </pre>
    \$mycurrency is '$mycurrency':
    <p>
    ";
    print $babelkit->select('currency', $display_lang, array(
                            value => $mycurrency
    ));

    #
    # Day Radiobox.
    #

    $day = $_POST['day'];
    print "</td></tr><tr><td>
    <b>Radiobox for days of the week.</b>
    <p>Constrain choices to the weekdays (1-5).
    <br>A blank separator displays them all on one line.
    <pre>
print \$babelkit->radio('day', \$display_lang, array(
                        subset =&gt; array(1, 2, 3, 4, 5),
                        sep    =&gt; ''
));
    </pre>
    'day' is '$day'.
    <p>
    ";
    print $babelkit->radio('day', $display_lang, array(
                           subset => array(1, 2, 3, 4, 5),
                           sep    => ''
    ));

    #
    # Country Select Multiple.
    #

    $country = $_POST['country'];
    if (!is_array($country)) $country = array();
    $countrystr = join(',', $country);
    print "</td></tr><tr><td>
    <b>Select multiple countries</b>.
    <p>Specify a window scrolling size of 10.
    <p>Experiment with Ctrl-click and Shift-click.
    <br>to select multiple countries.
    <pre>
print \$babelkit->multiple('country', \$display_lang, array(
                           size =&gt; 10
));
    </pre>
    'country' contains [$countrystr]:
    <p>
    ";
    print $babelkit->multiple('country', $display_lang, array(
                              size => 10
    ));

    #
    # Month Checkbox.
    #

    $month = $_POST['month'];
    if (!is_array($month)) $month = array();
    $monthstr = join(',', $month);
    print "</td></tr><tr><td>
    <b>Checkbox for multiple month selections.</b>
    <p>Simple no frills method call.
    <pre>
print \$babelkit->checkbox('month', \$display_lang);
    </pre>
    'month' contains [$monthstr]:
    <p>
    ";
    print $babelkit->checkbox('month', $display_lang);

    print "
    </td></tr><tr><td>
    <input type=submit value=\"Test BabelKit\">
    </form>
    </td>
    </tr>
    </table>
    </center>
    </body>
    </html>
    ";
}

?>
