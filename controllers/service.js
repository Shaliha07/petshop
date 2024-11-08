const Service = require("../models/Service.js");

//Create 
exports.createService=async(req,res)=>{
    const{ServiceName,description,sellingPrice,imageUrl}=req.body;
    try{
        //Check if service already exists
        const existingService=await Service.findOne({
            where:{serviceName,description,sellingPrice,imageUrl},
        });
        if(existingService){
            return res.status(400).json({error:"Service already exists."});
        }
        //Create new service 
        const newService =await Service.create({serviceName,description,sellingPrice,imageUrl,status:true});
        console.log("Service created successfully.",newService);
        res.status(201).json({
            message:"Service created successfully.",Service:newService
        });

    }catch(error){
        console.error("Error creating Service.",error);
        res.status(500).json({error:"Internel server "});
    }
}
//Update Service
exports.updateService= async (req,res)=>{
    const {id} =req.params;
    const{
      serviceName,
      description,
      sellingPrice,
      imageUrl
    }=req.body;

    try{
        const service = await service.findPK(id);
        if(!service){
            return req.status(404).json({MediaSession:"Service not found"});
        }
        if(serviceName){
            service.serviceName=serviceName;
        }
        if(description){
          service.description=description;
        }
        if(sellingPrice){
          service.sellingPrice=sellingPrice;
        }
        if(imageUrl){
          service.imageUrl=imageUrl;
        }
        await user.save();
        console.log("Service updated successfully");
        return res.status(200).json({message:"Service updated",service})

    }catch(error){
        console.error("Error in updating service",error);
        return res.status(500).json({message:"Unable to update service",error:error.message});
    }
};

// Get all services
exports.getServices = async (req, res) => {
    try {
      // Find the service with the status filter
      const services = await Service.findAll({ where: { status: true } });
  
      console.log("Services fetched successfully");
      return res.status(200).json({ services });
    } catch (error) {
      console.error("Error fetching services", error);
      return res
        .status(500)
        .json({ message: "Unable to get services", error: error.message });
    }
  };
  
  // Get a service by ID
  exports.getService = async (req, res) => {
    const { id } = req.params;
  
    try {
      // Find the service by ID
      const service = await Service.findByPk(id);
  
      if (!service) {
        return res.status(404).json({ message: "Service not found" });
      }
  
      console.log("Service fetched successfully");
      return res.status(200).json({ service });
    } catch (error) {
      console.error("Error fetching the service", error);
      return res
        .status(500)
        .json({ message: "Unable to get the service", error: error.message });
    }
  };
  
  // Delete a service (set status to false)
  exports.deleteService = async (req, res) => {
    const { id } = req.params;
  
    try {
      // Find the service by ID
      const service = await Service.findByPk(id);
  
      if (!service) {
        return res.status(404).json({ message: "Service not found" });
      }
  
      // Set service status to inactive/false
      service.status = false;
      await service.save();
  
      console.log("Service deleted successfully");
      return res.status(200).json({ message: "Service deleted successfully" });
    } catch (error) {
      console.error("Error deleting the service", error);
      return res
        .status(500)
        .json({ message: "Unable to delete the service", error: error.message });
    }
  };
