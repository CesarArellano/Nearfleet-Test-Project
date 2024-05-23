import express, { Application } from "express";
import addressRoutes from "../routes/addresses";

class Server {
  private app: Application;
  private port: string;
  private apiPaths = {
    addresses: "/api/addresses",
  };

  constructor() {
    this.app = express();
    this.port = process.env.PORT || "8000";

    // My routes
    this.routes();
  }

  routes(): void {
    this.app.use(this.apiPaths.addresses, addressRoutes);
  }

  listen(): void {
    this.app.listen(this.port, () => {
      console.log("Server is running on port:", this.port);
    });
  }
}

export default Server;
