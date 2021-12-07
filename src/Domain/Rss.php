<?php

namespace Watson\Domain;

use DateTime;

class Rss 
{
    private $title;
    private $description;
    private $buildDate;
    private $homeURL;

    private $links = [];
    private $fileBeginning = [];
    private $fileEnding = [];

    /**
     * Constructor
     * Add build date when the object is created
     */
    function __construct() {        
        $date = new DateTime('now');
        $this->buildDate = $date->format("D, d M Y H:i:s O");
    }

    /**
     * Merge arrays into a single string for the rss feed
     * 
     * @return string
     */
    function __toString()
    {
        //merge all arrays to forme the text file   
        $rss = array_merge($this->getFileBeginning(), $this->getChannel(), $this->getLinksElement(), $this->getFileEnding());

        return implode("\n", $rss);
    }

    /**
     * Get the value of title
     */ 
    private function getTitleElement()
    {
        return "        <title>" . $this->title . "</title>";
    }

    /**
     * Set the value of title
     *
     * @return  self
     */ 
    public function setTitle($title)
    {
        $this->title = $title;

        return $this;
    }

    /**
     * Get the value of description
     */ 
    private function getDescriptionElement()
    {
        return "        <description>" . $this->description . "</description>";
    }

    /**
     * Set the value of description
     *
     * @return  self
     */ 
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }
    

    /**
     * Get the value of buildDate
     */ 
    private function getBuildDateElement()
    {
        return "        <lastBuildDate>" . $this->buildDate . "</lastBuildDate>";
    }

    /**
     * Set the value of buildDate
     *
     * @return  self
     */ 
    public function setBuildDate(DateTime $buildDate)
    {
        $this->buildDate = $buildDate->format("D, d M Y H:i:s O");

        return $this;
    }

    /**
     * Get the value of homeURL
     */ 
    private function getHomeURLElement()
    {
        return "        <link>" . $this->homeURL . "</link>";
    }

    /**
     * Set the value of homeURL
     *
     * @return  self
     */ 
    public function setHomeURL($homeURL)
    {
        $this->homeURL = $homeURL;

        return $this;
    }

    /**
     * Get the value of links
     * 
     * @return array
     */ 
    private function getLinksElement()
    {
        $stringLinks = [];
        
        foreach($this->links as $link){
            $stringLinks[] = "        <item>";
            $stringLinks[] = "            <title>" . $link->getTitle() . "</title>";
            $stringLinks[] = "            <description><![CDATA[" . $link->getDesc() . "]]></description>";
            $stringLinks[] = "            <author>anonymous@anonymous (" . $link->getUser()->getUsername() . ")</author>";

            //set tag as categorie element
            $tags = $link->getTags();
            if(!empty($tags)){
                foreach($tags as $tag){
                    $stringLinks[] = "            <category>" . $tag->getTitle() . "</category>";
                }
            }

            $stringLinks[] = "            <link>" . $this->homeURL . "/link/" . $link->getId() . "</link>";
            $stringLinks[] = "            <guid isPermaLink=\"true\">" . $this->homeURL . "/link/" . $link->getId() . "</guid>";
            $stringLinks[] = "        </item>";
        }

        return $stringLinks;
    }

    /**
     * Set the value of links
     *
     * @return  self
     */ 
    public function setLinks($links)
    {
        $this->links = $links;

        return $this;
    }

    /**
     * Get the value of fileBeginning
     */ 
    private function getFileBeginning()
    {
        if(empty($this->fileBeginning)){
            $this->fileBeginning[] = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            $this->fileBeginning[] = "<rss version=\"2.0\">";
            $this->fileBeginning[] = "    <channel>";
        }

        return $this->fileBeginning;
    }

    /**
     * Get the value of fileEnding
     */ 
    private function getFileEnding()
    {
        if (empty($this->fileEnding)) {
            $this->fileEnding[] = "    </channel>";
            $this->fileEnding[] = "</rss>";
        }

        return $this->fileEnding;
    }

    /**
    * Get the value of channel
    */ 
    public function getChannel()
    {
        //build channel elements
        if(empty($this->channel)){
            $this->channel[] = $this->getTitleElement();
            $this->channel[] = $this->getDescriptionElement();
            $this->channel[] = $this->getBuildDateElement();
            $this->channel[] = $this->getHomeURLElement();
        }

        return $this->channel;
    }

    /**
     * Get the value of homeURL
     */ 
    public function getHomeURL()
    {
        return $this->homeURL;
    }

    /**
     * Get the value of description
     */ 
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Get the value of title
     */ 
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * Get the value of links
     */ 
    public function getLinks()
    {
        return $this->links;
    }

    /**
     * Get the value of buildDate
     */ 
    public function getBuildDate()
    {
        return $this->buildDate;
    }
}
