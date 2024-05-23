import express, { Application } from "express";

class Server {
  private app: Application;
  private port: string;

  constructor() {
    this.app = express();
    this.port = process.env.PORT || "8000";
  }

  listen(): void {
    this.app.listen(this.port, () => {
      console.log("Server is running on port: ", this.port);
    });
  }
}

export default Server;
