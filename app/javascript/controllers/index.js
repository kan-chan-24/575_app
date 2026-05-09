// app/javascript/controllers/index.js
import { application } from "./application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// または、個別にインポートしている場合
// import MoraeCounterController from "./morae_counter_controller"
// application.register("morae-counter", MoraeCounterController)