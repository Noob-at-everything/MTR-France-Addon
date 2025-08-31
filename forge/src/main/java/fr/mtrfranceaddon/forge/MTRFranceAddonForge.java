package fr.mtrfranceaddon.forge;

import fr.mtrfranceaddon.mod.common.Constants;
import fr.mtrfranceaddon.mod.common.Init;
import net.minecraftforge.eventbus.api.IEventBus;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.event.lifecycle.FMLCommonSetupEvent;
import net.minecraftforge.fml.event.lifecycle.FMLClientSetupEvent;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;

@Mod(Constants.MOD_ID)
public class MTRFranceAddonForge {

    public MTRFranceAddonForge() {
        IEventBus modEventBus = FMLJavaModLoadingContext.get().getModEventBus();
        modEventBus.addListener(this::commonSetup);
        modEventBus.addListener(this::clientSetup);
    }

    private void commonSetup(final FMLCommonSetupEvent event) {
        Init.init();
    }

    private void clientSetup(final FMLClientSetupEvent event) {
        Init.initClient();
    }
}
