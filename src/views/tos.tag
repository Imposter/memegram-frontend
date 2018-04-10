<tos-view class="container">
    <div class="row">
        <div class="col s12 m8 offset-m2">
            <div class="card">
                <div class="card-content black-text">
                    <!-- Generated using: https://getterms.io/ -->
                    <span class="card-title">
                        <h5>Terms of Service</h5>
                    </span>
                    <p>
                        By accessing the website at
                        <a href="{ window.location.href.split('#')[0] }">{ window.location.href.split('#')[0] }</a>, you are agreeing to be bound by these terms of service, all applicable
                        laws and regulations, and agree that you are responsible for compliance with any applicable local
                        laws. If you do not agree with any of these terms, you are prohibited from using or accessing this
                        site. The materials contained in this website are protected by applicable copyright and trademark
                        law.
                    </p>
                    <div class="section"></div>
                    <div class="row">
                        <ul class="collapsible">
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">view_headline</i>Use License
                                </div>
                                <div class="collapsible-body">
                                    <ol type="a">
                                        <li>
                                            Permission is granted to temporarily download one copy of the materials (information or software) on { opts.app.name }'s
                                            website for personal, non-commercial transitory viewing only. This is the grant
                                            of a license, not a transfer of title, and under this license you may not:
                                            <ol type="i">
                                                <li>modify or copy the materials;</li>
                                                <li>
                                                    use the materials for any commercial purpose, or for any public display (commercial or non-commercial);
                                                </li>
                                                <li>
                                                    attempt to decompile or reverse engineer any software contained on { opts.app.name }'s website;
                                                </li>
                                                <li>
                                                    remove any copyright or other proprietary notations from the materials; or
                                                </li>
                                                <li>
                                                    transfer the materials to another person or "mirror" the materials on any other server.
                                                </li>
                                            </ol>
                                        </li>
                                        <li>
                                            This license shall automatically terminate if you violate any of these restrictions and may be terminated by { opts.app.name
                                            } at any time. Upon terminating your viewing of these materials or upon the termination
                                            of this license, you must destroy any downloaded materials in your possession
                                            whether in electronic or printed format.
                                        </li>
                                    </ol>
                                </div>
                            </li>
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">library_books</i>Disclaimer
                                </div>
                                <div class="collapsible-body">
                                    <ol type="a">
                                        <li>The materials on { opts.app.name }'s website are provided on an 'as is' basis. {
                                            opts.app.name } makes no warranties, expressed or implied, and hereby disclaims
                                            and negates all other warranties including, without limitation, implied warranties
                                            or conditions of merchantability, fitness for a particular purpose, or non-infringement
                                            of intellectual property or other violation of rights.</li>
                                        <li>Further, { opts.app.name } does not warrant or make any representations concerning
                                            the accuracy, likely results, or reliability of the use of the materials on its
                                            website or otherwise relating to such materials or on any sites linked to this
                                            site.
                                        </li>
                                    </ol>
                                </div>
                            </li>
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">vpn_key</i>Limitations
                                </div>
                                <div class="collapsible-body">
                                    <p>In no event shall { opts.app.name } or its suppliers be liable for any damages (including,
                                        without limitation, damages for loss of data or profit, or due to business interruption)
                                        arising out of the use or inability to use the materials on { opts.app.name }'s website,
                                        even if { opts.app.name } or a { opts.app.name } authorized representative has been
                                        notified orally or in writing of the possibility of such damage. Because some jurisdictions
                                        do not allow limitations on implied warranties, or limitations of liability for consequential
                                        or incidental damages, these limitations may not apply to you.
                                    </p>
                                </div>
                            </li>
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">check_circle</i>Accuracy of materials
                                </div>
                                <div class="collapsible-body">
                                    <p>The materials appearing on { opts.app.name }'s website could include technical, typographical,
                                        or photographic errors. { opts.app.name } does not warrant that any of the materials
                                        on its website are accurate, complete or current. { opts.app.name } may make changes
                                        to the materials contained on its website at any time without notice. However { opts.app.name
                                        } does not make any commitment to update the materials.</p>
                                </div>
                            </li>
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">link</i>Link
                                </div>
                                <div class="collapsible-body">
                                    <p>{ opts.app.name } has not reviewed all of the sites linked to its website and is not
                                        responsible for the contents of any such linked site. The inclusion of any link does
                                        not imply endorsement by { opts.app.name } of the site. Use of any such linked website
                                        is at the user's own risk.
                                    </p>
                                </div>
                            </li>
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">build</i>Modifications
                                </div>
                                <div class="collapsible-body">
                                    { opts.app.name } may revise these terms of service for its website at any time without notice. By using this website you
                                    are agreeing to be bound by the then current version of these terms of service.
                                </div>
                            </li>
                            <li>
                                <div class="collapsible-header">
                                    <i class="material-icons">gavel</i> Governing Law
                                </div>
                                <div class="collapsible-body">
                                    These terms and conditions are governed by and construed in accordance with the laws of Canada and you irrevocably submit
                                    to the exclusive jurisdiction of the courts in the country.
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        this.on("mount", function () {
            $(document).ready(function () {
                var elem = document.querySelector(".collapsible");
                var instance = M.Collapsible.init(elem);
                instance.open(0);
            });
        });
    </script>
</tos-view>