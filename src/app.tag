<app>
	<header>
		<div class="navbar-fixed">
			<nav>
				<div class="nav-wrapper">
					<div class="nav row">
						<div class="col s2 m12">
							<!-- Logo icon -->
							<a href="#" onclick={ openDisplay } class="brand-logo">
								<img class="logo-icon hide-on-med-and-down" src="images/memegram-icon-light.png" />
								<img class="logo-title" src="images/memegram-title-light.png" />
							</a>
						</div>

						<a href="#" data-target="side-navigation" class="sidenav-trigger">
							<i class="material-icons">menu</i>
						</a>
						<div class="col s2 m12 hide-on-med-and-down right">
							<ul class="right">
								<li>
									<a href="#" onclick={ openSearch }>
										<i class="material-icons">search</i>
									</a>
								</li>
								<li>
									<a href="#" onclick={ openCreate }>
										<i class="material-icons">create</i>
									</a>
								</li>
								<li>
									<a href="#" onclick={ openDisplay }>
										<i class="material-icons">explore</i>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</nav>
		</div>

		<!-- Sidebar -->
		<ul id="side-navigation" class="sidenav">
			<li>
				<a href="#" onclick={ openSearch }>
					<i class="material-icons">search</i>Search
				</a>
			</li>
			<li>
				<a href="#" onclick={ openCreate }>
					<i class="material-icons">create</i>Create new Post
				</a>
			</li>
			<li>
				<a href="#" onclick={ openDisplay }>
					<i class="material-icons">explore</i>Explore
				</a>
			</li>
		</ul>
	</header>

	<!-- Body -->
	<main class="grey lighten-5">
		<div class="section"></div>
		<div id="app-body"></div>
	</main>

	<!-- Footer -->
	<footer class="page-footer">
		<!--
		<div class="container">
			<div class="row">
				<div class="col l6 s12">
					<h5 class="white-text">Footer Content</h5>
					<p class="grey-text text-lighten-4">You can use rows and columns here to organize your footer content.</p>
				</div>
				<div class="col l4 offset-l2 s12">
					<h5 class="white-text">Links</h5>
					<ul>
						<li>
							<a class="grey-text text-lighten-3" href="#rules">Rules</a>
						</li>
						<li>
							<a class="grey-text text-lighten-3" href="#" onclick={ openTermsOfService }>Terms of Service</a>
						</li>
						<li>
							<a class="grey-text text-lighten-3" href="#contact">Contact Us</a>
						</li>
						<li>
							<a class="grey-text text-lighten-3" href="#about">About Us</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		-->
		<div class="footer-copyright">
			<div class="container">
				Copyright &copy; { opts.app.date.getFullYear() } { opts.app.name }. All Rights Reserved.
			</div>
		</div>
	</footer>

	<script>
		import { app } from "./scripts/application";

		this.on("mount", function () {
			// Setup sidenav
			$("#side-navigation").sidenav();
		});

		this.openSearch = (e) => app.loadRoute("search");
		this.openCreate = (e) => app.loadRoute("create");
		this.openDisplay = (e) => app.loadRoute("display");
		this.openTermsOfService = e => app.loadRoute("tos");
	</script>

</app>