// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
// Uncomment this line if you want to use the Stimulus Twilio Video controller
//   without inheriting it:
// import TwilioVideoController from 'stimulus-twilio-video'

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
// Uncomment this line if you want to use the Stimulus Twilio Video controller
//   without inheriting it:
// application.register('video-call', TwilioVideoController)
application.load(definitionsFromContext(context))
