import { Routes } from '@angular/router';

import { LandingPageComponent } from './components/landing/landing.component';
import { MovieDetailsComponent } from './components/movies/moviedetails/moviedetails.component';
import { SearchResultsComponent } from './components/movies/searchresults/searchresults.component';
import { UserDetailsComponent } from './components/users/userdetails/userdetails.component';
import { AdminPanelComponent } from './components/users/adminpanel/adminpanel.component';
import { RegistrationComponent } from './components/registration/registration.component';

export const appRoutes: Routes = [
  { path: 'home', component: LandingPageComponent },
  { path: 'movies/:id', component: MovieDetailsComponent },
  { path: 'search', component: SearchResultsComponent },
  { path: 'admins', component: AdminPanelComponent },
  { path: 'users/registration', component: RegistrationComponent},
  { path: 'users/:id', component: UserDetailsComponent },
  { path: '', redirectTo: '/home', pathMatch: 'full' }
];
