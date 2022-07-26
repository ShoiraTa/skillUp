// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@rails/actiontext';
import { Turbo } from '@hotwired/turbo-rails';
import 'controllers';
import 'jquery';
// import 'jquery_ujs';
// import 'popper';
import 'bootstrap';
//= require rails-ujs
//= require_tree .
import 'trix';
Turbo.session.drive = false;
